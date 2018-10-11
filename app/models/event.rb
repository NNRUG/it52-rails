# coding: utf-8
# == Schema Information
#
# Table name: events
#
#  id           :integer          not null, primary key
#  title        :string(255)      not null
#  created_at   :datetime
#  updated_at   :datetime
#  organizer_id :integer
#  published    :boolean          default(FALSE)
#  description  :text
#  started_at   :datetime
#  title_image  :string(255)
#  place        :string(255)
#  published_at :datetime
#  slug         :string(255)
#  location     :point
#

class Event < ApplicationRecord
  paginates_per 20

  attr_accessor :has_foreign_link

  mount_uploader :title_image, EventTitleImageUploader

  belongs_to :organizer, class_name: 'User'

  has_many :event_participations
  has_many :participants, class_name: 'User', through: :event_participations, source: :user

  validates :title, presence: true
  validates :organizer, presence: true
  validates :place, presence: true
  validates :description, presence: true
  validates :started_at, presence: true

  scope :ordered_desc,  -> { order(started_at: :desc) }
  scope :ordered_asc,   -> { order(started_at: :asc) }

  scope :published, -> { where(published: true) }

  scope :past,    -> { ordered_desc.where("started_at < ?", Time.now.beginning_of_day ) }
  scope :future,  -> { ordered_asc.where("started_at >= ?", Time.now.beginning_of_day ) }

  scope :held_in,  -> (year, month) {
    start   = month.nil? ? Date.new(year) : Date.new(year, month)
    finish  = month.nil? ? start.end_of_year : start.end_of_month
    ordered_desc.where("started_at BETWEEN ? AND ?", start, finish)
  }

  scope :visible_by_user, -> (user) {
    return published if user.nil?
    user.admin? ? all : where("organizer_id = ? OR published = ?", user.id, true)
  }


  extend FriendlyId
  friendly_id :slug_candidates, use: :history

  def slug_candidates
    [[ started_at.strftime("%Y-%m-%d"), title ]]
  end

  def should_generate_new_friendly_id?
    title_changed? || started_at_changed? || super
  end

  def user_participated?(user)
    user && event_participations.find_by(user_id: user.id)
  end

  def participation_for(user)
    event_participations.find_by(user_id: user.id)
  end

  def past?
    started_at < Time.now
  end

  def publish!
    self.published_at = Time.now
    self.toggle :published
    save!
  end

  def cancel_publication!
    self.toggle :published
    save!
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
    link = Rails.application.routes.url_helpers.event_url(self, host: Figaro.env.mailing_host)
    link += '?' + { utm_source: 'telegram', utm_medium: 'link', utm_campaign: friendly_id }.to_query
    md_title = "#{id} — [#{title.strip}](#{link})"
    md_date = "*#{I18n.l(started_at, format: :date_time_full)}*"
    md_place = "[#{place}](http://maps.yandex.ru/?text=#{URI.encode(place.strip)})"
    header = [md_title, md_date, md_place].join("\n")
    return header if short
    fixed_description = description.gsub(/\*\*/, '_').gsub(/^\*\s/, '- ')
    [header, fixed_description].join("\n"*2)
  end

  def to_meta_tags
    simple_description = EventDecorator.decorate(self).simple_description
    {
      title: [I18n.l(started_at, format: :date), title],
      description: simple_description,
      canonical: canonical_url,
      publisher: Figaro.env.mailing_host,
      author: Rails.application.routes.url_helpers.user_url(organizer, host: Figaro.env.mailing_host),
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
    "#{created_at.iso8601}-#{started_at.iso8601}-#{id}@#{Figaro.env.mailing_host}"
  end

  def to_ics
    event = Icalendar::Event.new
    event.dtstart = started_at.strftime("%Y%m%dT%H%M%S")
    event.summary = title
    event.description = self.decorate.simple_description
    event.location = place
    event.created = created_at
    event.last_modified = updated_at
    event.uid = ics_uid
    event.url = canonical_url
    event
  end

  def canonical_url
    Rails.application.routes.url_helpers.event_url(self, host: Figaro.env.mailing_host)
  end
end
