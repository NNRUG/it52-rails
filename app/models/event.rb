# frozen_string_literal: true

# == Schema Information
#
# Table name: events
#
#  id              :integer          not null, primary key
#  title           :string(255)      not null
#  created_at      :datetime
#  updated_at      :datetime
#  organizer_id    :integer
#  published       :boolean          default(FALSE)
#  description     :text
#  started_at      :datetime
#  title_image     :string(255)
#  place           :string(255)
#  published_at    :datetime
#  slug            :string(255)
#  location        :point
#  foreign_link    :string
#  pageviews       :integer          default(0)
#  kind            :integer          default("event")
#  address_id      :bigint
#  address_comment :string
#

class Event < ApplicationRecord
  DEFAULT_FILTER_PARAMS = { kind: 'all',
                            status: 'future',
                            tag: nil }.freeze
  paginates_per 10

  acts_as_taggable_on :tags

  attr_accessor :has_foreign_link

  mount_uploader :title_image, EventTitleImageUploader

  before_validation :clear_price_unless_paid
  before_validation :clear_participants_limit_unless_enabled
  before_create :migrate_to_address, if: :place_changed?

  after_save :enqueue_published_notification, if: :saved_change_to_published?
  before_update :migrate_to_address, if: :place_changed?

  belongs_to :organizer, class_name: 'User'
  belongs_to :address, optional: true

  enum kind: {
    event: 0,
    education: 1,
    conference: 2,
    summit: 3,
    drinkup: 4,
    hackathon: 5,
    closed_meeting: 6,
    webinar: 7,
    festival: 8,
    online_training: 9,
    expo: 10,
    forum: 11,
    workshop: 12,
    ctf: 13,
    bootcamp: 14,
    training: 15
  }

  has_many :event_participations
  has_many :participants, class_name: 'User', through: :event_participations, source: :user
  has_many :event_categories, dependent: :destroy
  has_many :categories, through: :event_categories

  validates :title, presence: true
  validates :organizer, presence: true
  validates :place, presence: true
  validates :description, presence: true
  validates :started_at, presence: true
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true
  validates :participants_limit, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true
  validate :title_image_file_size
  validate :categories_presence
  validate :price_presence_when_paid
  validate :participants_limit_presence_when_enabled

  scope :ordered_desc, -> { order(started_at: :desc) }
  scope :ordered_asc,  -> { order(started_at: :asc) }

  scope :published,  -> { where(published: true) }
  scope :unapproved, -> { where(published: false) }

  scope :past,    -> { ordered_desc.where('started_at < ?', Time.current.beginning_of_day).ordered_desc }
  scope :future,  -> { ordered_asc.where('started_at >= ?', Time.current.beginning_of_day).ordered_asc }

  # События, которые начинаются ровно через 2 дня (для отправки напоминаний участникам)
  scope :starting_in_2_days, -> {
    day = 2.days.from_now
    where(started_at: day.beginning_of_day..day.end_of_day)
  }

  scope :held_in, lambda { |year, month|
    start   = month.nil? ? Date.new(year) : Date.new(year, month)
    finish  = month.nil? ? start.end_of_year : start.end_of_month
    ordered_desc.where('started_at BETWEEN ? AND ?', start, finish)
  }

  scope :visible_by_user, lambda { |user = nil|
    return published if user.nil?

    user.admin? ? all : where('organizer_id = ? OR published = ?', user.id, true)
  }

  extend FriendlyId
  friendly_id :slug_candidates, use: :history

  def self.humanized_kinds_map
    all_pairs = kinds.keys.map { |k| [I18n.t("activerecord.attributes.event.kinds.#{k}"), k] }
    event_pair = all_pairs.find { |_, key| key == 'event' }
    rest = all_pairs.reject { |_, key| key == 'event' }.sort_by(&:first)
    event_pair ? [event_pair] + rest : rest
  end

  def self.sorted_kind_filter_options
    keys = %w[all] + kinds.keys
    options = keys.map { |k| [k, I18n.t("events.index.kind_filter.#{k}")] }
    all_pair = options.find { |key, _| key == 'all' }
    event_pair = options.find { |key, _| key == 'event' }
    rest = options.reject { |key, _| %w[all event].include?(key) }.sort_by(&:last)
    [all_pair, event_pair].compact + rest
  end

  def self.filter_by(kind: 'all', status: 'future', tag: nil)
    records = all
    records = records.send(kind.to_sym) if kind.in?(kinds.keys)
    records = records.send(status.to_sym) if status.to_sym.in?(%i[past future])
    records = records.tagged_with(tag) if tag
    records
  end

  def slug_candidates
    [[started_at.strftime('%Y-%m-%d'), I18n.transliterate(title)]]
  end

  def should_generate_new_friendly_id?
    title_changed? || started_at_changed? || super
  end

  def user_participated?(user)
    user && event_participations.find_by(user_id: user.id)
  end

  def participants_count
    participants.size
  end

  def participation_for(user)
    event_participations.find_by(user_id: user.id)
  end

  def past?
    started_at < Time.zone.now
  end

  def publish!
    self.published_at = Time.zone.now
    toggle :published
    save!
  end

  def enqueue_published_notification
    return unless published?

    NotifySubscribersAboutEventPublicationJob.perform_later(id)
    SendEventToTelegramJob.perform_later(id) if telegram_configured?
  end

  def telegram_configured?
    token = ENV['telegram_bot_token']
    chat_id = ENV['telegram_chat_id']
    token.present? && token != 'telegram_bot_token' && chat_id.present? && chat_id != 'telegram_chat_id'
  end

  def cancel_publication!
    toggle :published
    save!
  end

  def update_pageviews!
    service = UpdateEventPageviews.new([self])
    service.update_pageviews!
  end

  def send_to_telegram
    post = Telegram::Message.new(:message)
    result = post.send_message(construct_telegram_message)
  rescue Telegram::ParseError, Telegram::LongMessageError => e
    result = post.send_message(construct_telegram_message(true))
  ensure
    result
  end

  def construct_telegram_message(short = false)
    link = Rails.application.routes.url_helpers.event_url(self, host: ENV.fetch('mailing_host') { 'mailing_host' })
    link += '?' + { utm_source: 'telegram', utm_medium: 'link', utm_campaign: friendly_id }.to_query
    md_title = "#{id} — [#{title.strip}](#{link})"
    md_date = "*#{I18n.l(started_at, format: :date_time_full)}*"
    md_place = "[#{place}](http://maps.yandex.ru/?text=#{URI.encode(place.strip)})"
    header = [md_title, md_date, md_place].join("\n")
    return header if short

    fixed_description = description.gsub(/\*\*/, '_').gsub(/^\*\s/, '- ')
    [header, fixed_description].join("\n" * 2)
  end

  def to_meta_tags
    simple_description = EventDecorator.decorate(self).simple_description
    {
      title: [I18n.l(started_at, format: :date), title],
      description: simple_description,
      canonical: canonical_url,
      publisher: ENV.fetch('mailing_host') { 'mailing_host' },
      author: Rails.application.routes.url_helpers.user_url(organizer, host: ENV.fetch('mailing_host') { 'mailing_host' }),
      image_src: title_image.fb_1200.url,
      og: {
        title: [I18n.l(started_at, format: :date), title].join(' ~ '),
        url: canonical_url,
        description: simple_description,
        image: title_image.fb_1200.url,
        updated_time: updated_at
      }
    }
  end

  def ics_uid
    "#{created_at.iso8601}-#{started_at.iso8601}-#{id}@#{ENV.fetch('mailing_host') { 'mailing_host' }}"
  end

  def to_ics
    event = Icalendar::Event.new
    event.dtstart = Icalendar::Values::DateTime.new started_at, tzid: Rails.configuration.time_zone
    event.summary = title
    event.description = decorate.simple_description
    event.location = place
    event.created = created_at
    event.last_modified = updated_at
    event.uid = ics_uid
    event.url = canonical_url
    event.organizer = Icalendar::Values::CalAddress.new("mailto:#{organizer.email}", cn: organizer.to_s)
    event
  end

  def canonical_url
    Rails.application.routes.url_helpers.event_url(self, host: ENV.fetch('mailing_host') { 'mailing_host' })
  end

  def user_foreign_link(user)
    build_foreign_link(user)
  end

  def telegram_channel_url
    return nil if telegram_channel.blank?

    value = telegram_channel.strip
    return value if value.match?(/\Ahttps?:\/\//i)

    "https://t.me/#{value.delete_prefix('@')}"
  end

  def title_image_file_size
    return if title_image.blank?

    file = title_image.file
    return unless file.respond_to?(:size) && file.size

    return if file.size <= 800.kilobytes

    errors.add(:title_image, :file_too_large, max: 800)
  end

  def categories_presence
    return if category_ids.reject(&:blank?).any?

    errors.add(:category_ids, :categories_required)
  end

  def price_presence_when_paid
    return unless paid?

    errors.add(:price, :blank) if price.blank?
  end

  def clear_price_unless_paid
    self.price = nil unless paid?
  end

  def participants_limit_presence_when_enabled
    return unless registration_limit_enabled?

    errors.add(:participants_limit, :blank) if participants_limit.blank?
  end

  def clear_participants_limit_unless_enabled
    self.participants_limit = nil unless registration_limit_enabled?
  end

  def migrate_to_address
    suggestions = DaData::Request.suggest_address("Нижний Новгород, #{place}")
    main_suggestions = DaData::Request.suggest_address(suggestions['suggestions'].first['unrestricted_value'], count: 1)
    address = Address.first_or_create_from_dadata(main_suggestions['suggestions'].first)
    self.place = main_suggestions['suggestions'].first['value']
    self.address_id = address.id
    self
  rescue Exception => e
    Rollbar.error(e, event: to_meta_tags)
  end

  private

  def build_foreign_link(user)
    return nil if foreign_link.blank?

    url = URI.parse(foreign_link)
    url_params = Rack::Utils.parse_nested_query(url.query).deep_symbolize_keys
    params = case url.host
             when /timepad\.ru/
               {
                 twf_prefill_attendees: { 0 => {
                   name: user.first_name,
                   surname: user.last_name,
                   mail: user.email
                 } },
                 twf_prefill_aux: [{ our_user: user.id }]
               }
             else
               {}
    end
    params = params.merge(utm_source: 'it52')
    [url.to_s, params.to_query].join('?')
  end
end
