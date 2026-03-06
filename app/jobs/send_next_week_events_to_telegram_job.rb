 # frozen_string_literal: true

 class SendNextWeekEventsToTelegramJob < ApplicationJob
   queue_as :default

   def perform
    return unless any_telegram_configured?

     start_time = Time.zone.today.beginning_of_day
     end_time = 7.days.from_now.end_of_day

    events = Event.published.where(started_at: start_time..end_time).ordered_asc
    return if events.empty?

    text = build_digest_message(events, start_time, end_time)

    post = Telegram::Message.new(:message)
    post.send_message(text)
  end

  private

  def any_telegram_configured?
    Event.where(published: true).limit(1).any?(&:telegram_configured?)
  end

  def build_digest_message(events, start_time, end_time)
    from_str = I18n.l(start_time.to_date, format: :date)
    to_str   = I18n.l(end_time.to_date,   format: :date)

    header = "*#{I18n.t('telegram_digest.title', from: from_str, to: to_str)}*"

    blocks = events.map { |event| format_event_block(event) }

    ([header] + blocks).join("\n\n")
  end

  def format_event_block(event)
    event_link = event_url(event)
    kind_label = I18n.t("activerecord.attributes.event.kinds.#{event.kind}")
    title_with_link = "[#{event.title.strip}](#{event_link})"
    line1 = "*🏛 [#{kind_label}] — #{title_with_link}*"
    date_place = "#{I18n.l(event.started_at, format: :date_time_full)}, #{event.place}"

    lines = [line1, date_place]

    if event.telegram_channel_url.present?
      lines << "#{I18n.t('telegram_digest.telegram_channel')}: [#{event.telegram_channel_url}](#{event.telegram_channel_url})"
    end

    if event.paid? && event.price.present?
      lines << I18n.t('telegram_digest.cost', price: event.price)
    end

    if event.registration_limit_enabled? && event.participants_limit.present?
      lines << I18n.t('telegram_digest.participants_limit', count: event.participants_limit)
    end

    lines << "[#{I18n.t('telegram_digest.register')}](#{event_link})"

    lines.join("\n")
  end

  def event_url(event)
    url = Rails.application.routes.url_helpers.event_url(
      event,
      host: ENV.fetch('mailing_host') { 'mailing_host' }
    )
    url + '?' + {
      utm_source: 'telegram',
      utm_medium: 'digest',
      utm_campaign: event.friendly_id
    }.to_query
  end
 end

