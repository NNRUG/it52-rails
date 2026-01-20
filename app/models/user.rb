# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(128)      default(""), not null
#  password_salt          :string(255)      default(""), not null
#  created_at             :datetime
#  updated_at             :datetime
#  reset_password_token   :string(255)
#  nickname               :string(255)      default("")
#  role                   :integer
#  first_name             :string(255)
#  last_name              :string(255)
#  bio                    :text
#  avatar_image           :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  slug                   :string(255)
#  website                :string(255)
#  subscription           :boolean
#  employment             :string
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :trackable, :validatable, :confirmable, :omniauthable

  enum role: { member: 0, admin: 1 }

  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications

  has_many :owner_of_events, -> { order(started_at: :desc) }, class_name: 'Event', foreign_key: 'organizer_id'
  has_many :event_participations
  has_many :member_in_events, -> { order(started_at: :desc).published }, class_name: 'Event', through: :event_participations, source: :event

  before_create :assign_default_role, if: -> { role.nil? }
  before_create :set_subscription, if: -> { email.present? && subscription.nil? }

  before_validation :normalize_url, if: :website_changed?

  after_create :sync_with_mailchimp

  validates :website, format: { with: URI.regexp(%w[http https]) }, allow_nil: true
  validate :should_have_email_before_subscription

  scope :subscribed, -> { where(subscription: true) }

  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  mount_uploader :avatar_image, UserAvatarUploader

  def full_name
    [first_name, last_name].compact.join(' ').presence || nickname.presence || email
  end

  def profile_link
    url_helpers.user_url(self, host: ENV.fetch('mailing_host') { 'mailing_host' })
  end

  def to_s
    full_name
  end

  def slug_candidates
    auth_uids = authentications.pluck(:uid)
    [
      :nickname,
      %i[first_name last_name],
      %i[nickname first_name last_name],
      auth_uids,
      %i[nickname first_name last_name email],
      :email,
      %i[nickname first_name last_name email] + auth_uids
    ]
  end

  def should_generate_new_friendly_id?
    slug.blank? || nickname_changed? || first_name_changed? || last_name_changed? || super
  end

  def self.new_with_session(params, session)
    super.tap do |_user|
      if data = session['devise.oauth_data']
        user = from_omniauth data
      end
    end
  end

  def self.from_omniauth(auth, current_user = nil)
    authentication = Authentication.where(provider: auth[:provider], uid: auth[:uid])
                                   .first_or_initialize.set_attributes_from_omniauth(auth)

    user = current_user || authentication.user
    user ||= where(email: auth['info']['email']).first_or_create

    unless user.has_identity? auth[:provider]
      user.authentications << authentication
    end
    user.skip_confirmations! if user.confirmed? || !user.email_required?
    user = UpdateUserFromOmniauth.new(user, auth[:provider], auth[:info]).set_attributes
    user.save
    user
  end

  def skip_confirmations!
    skip_confirmation!
    skip_reconfirmation!
  end

  def has_identity?(provider)
    provider.in? authentications.map(&:provider)
  end

  def unlinked_providers
    self.class.omniauth_providers.map(&:to_s) - authentications.pluck(:provider)
  end

  def password_required?
    super && authentications.blank?
  end

  def email_required?
    super && authentications.blank?
  end

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end

  def sync_with_mailchimp
    # disabled
    return nil
    return nil if email.blank?
    return unless Rails.env.production?

    MailchimpSynchronizer.new(self).sync!
  end

  private

  def set_subscription
    self.subscription = true
  end

  def normalize_url
    self.website = if result = website.to_url
                     result
                   else
                     website
    end
    self.website = nil if website.blank?
  end

  def assign_default_role
    self.role = :member
  end

  def should_have_email_before_subscription
    if subscription? && email.blank?
      self.subscription = false
      errors.add :subscription, I18n.t('activerecord.errors.models.user.attributes.subscription.email_absent')
    end
  end
end
