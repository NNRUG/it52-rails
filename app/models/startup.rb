# frozen_string_literal: true

class Startup < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true
  validates :author_id, presence: true, numericality: true
  validate :logo_file_size

  belongs_to :author, class_name: 'User'

  mount_uploader :logo, StartupLogoUploader

  extend FriendlyId
  friendly_id :slug_candidates, use: :history

  def logo_file_size
    return if logo.blank?

    file = logo.file
    return unless file.respond_to?(:size) && file.size

    return if file.size <= 800.kilobytes

    errors.add(:logo, :file_too_large, max: 800)
  end

  def slug_candidates
    [I18n.transliterate(title),
     [id, I18n.transliterate(title)]]
  end

  def should_generate_new_friendly_id?
    title_changed? || super
  end

  def to_meta_tags
    {
      title: title,
      description: rendered_description,
      canonical: canonical_url,
      publisher: ENV.fetch('mailing_host') { 'mailing_host' },
      author: Rails.application.routes.url_helpers.user_url(author, host: ENV.fetch('mailing_host') { 'mailing_host' }),
      image_src: ActionController::Base.helpers.image_url(logo.big.url),
      og: {
        title: title,
        url: canonical_url,
        description: description,
        image: ActionController::Base.helpers.image_url(logo.big.url),
        updated_time: updated_at
      }
    }
  end

  def canonical_url
    Rails.application.routes.url_helpers.startup_url(self, host: ENV.fetch('mailing_host') { 'mailing_host' })
  end

  def rendered_description
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new(autolink: true, filter_html: true, hard_wrap: true))
    markdown.render(description).html_safe
  end

  def to_s
    title
  end
end
