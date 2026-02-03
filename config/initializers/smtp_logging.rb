# frozen_string_literal: true

# Логирование SMTP: настройки при старте (без пароля), каждая доставка (address/port, from/to, длительность).
Rails.application.config.after_initialize do
  mailer_log = Rails.root.join('log', 'mailer.log')
  smtp_logger = ActiveSupport::Logger.new(mailer_log)
  smtp_logger.level = Logger::DEBUG
  smtp_logger.formatter = proc do |severity, datetime, _progname, msg|
    "[#{datetime.utc.iso8601}] #{severity}: #{msg}\n"
  end

  if ActionMailer::Base.delivery_method == :smtp
    settings = ActionMailer::Base.smtp_settings || {}
    conn_info = {
      address: settings[:address],
      port: settings[:port],
      domain: settings[:domain],
      authentication: settings[:authentication],
      user_name: settings[:user_name],
      tls: settings[:tls],
      enable_starttls_auto: settings[:enable_starttls_auto]
    }.compact
    smtp_logger.info("[SMTP] config loaded: #{conn_info.inspect}")
    yandex_login = settings[:user_name].to_s.presence
    smtp_logger.info("[SMTP] Yandex SMTP auth login: #{yandex_login.present? ? yandex_login : '(not set)'}")
  end

  ActiveSupport::Notifications.subscribe('deliver.action_mailer') do |_name, start, finish, _id, payload|
    mail = payload[:mail]
    next unless mail

    smtp = ActionMailer::Base.smtp_settings
    conn_info = smtp ? { address: smtp[:address], port: smtp[:port] }.compact : {}
    duration_ms = ((finish - start) * 1000).round
    # Mail::Message has #from/#to; String has ActiveSupport's #from(n), so avoid calling .from on String
    from_val = to_val = subject_val = nil
    if mail.respond_to?(:header) && mail.header
      from_val = mail.header['From']&.value
      to_val = mail.header['To']&.value
      subject_val = mail.header['Subject']&.value
    end

    smtp_logger.info(
      "[SMTP] connection=#{conn_info.inspect} from=#{from_val} to=#{to_val} " \
      "subject=#{subject_val.inspect} duration_ms=#{duration_ms}"
    )
  end

  ActiveSupport::Notifications.subscribe('process.action_mailer') do |_name, start, finish, _id, payload|
    action = payload[:action]
    mailer = payload[:mailer]
    next unless action && mailer

    duration_ms = ((finish - start) * 1000).round
    smtp_logger.debug("[SMTP] mailer=#{mailer} action=#{action} duration_ms=#{duration_ms}")
  end
end
