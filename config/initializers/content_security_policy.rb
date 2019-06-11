# Be sure to restart your server when you modify this file.

# Define an application-wide content security policy
# For further information see the following documentation
# https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Security-Policy

Rails.application.config.content_security_policy do |policy|
  policy.default_src :none
  policy.font_src    :self, :https, :data, 'https://assets.it52.info', 'https://fonts.googleapis.com'
  policy.img_src     :self, :https, :data, 'https://assets.it52.info', 'https://mc.yandex.ru/'
  policy.frame_src  'https://yastatic.net', 'https://money.yandex.ru', 'https://www.patreon.com'
  policy.script_src  :self, :https, :unsafe_inline, 'https://assets.it52.info', 'https://bam.nr-data.net', 'js-agent.newrelic.com', '*.newrelic.com', 'https://mc.yandex.ru/', 'ajax.cloudflare.com'
  policy.style_src   :self, :https, :unsafe_inline, :blob, 'https://fonts.googleapis.com', 'https://assets.it52.info'

#   # Specify URI for violation reports
#   # policy.report_uri "/csp-violation-report-endpoint"

  if Rails.env.development?
    policy.connect_src :self, :https, 'http://localhost:3035', 'ws://localhost:3035'
  else
    policy.connect_src :self, :https
  end
  #   policy.connect_src :self, :https, 'http://localhost:3035', 'ws://localhost:3035'
  #   policy.script_src :self, :https, 'bam.nr-data.net', 'js-agent.newrelic.com', '*.newrelic.com', 'www.googletagmanager.com'
  # else
  #   policy.connect_src :self, :https
  # #   policy.script_src :self, :https, :unsafe_inline, 'bam.nr-data.net', 'js-agent.newrelic.com'
  # end
end

# If you are using UJS then enable automatic nonce generation
Rails.application.config.content_security_policy_nonce_generator = -> (request) { SecureRandom.base64(16) }

# Report CSP violations to a specified URI
# For further information see the following documentation:
# https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Security-Policy-Report-Only
# Rails.application.config.content_security_policy_report_only = true

  # policy.connect_src :self, :https, 'http://localhost:3035', 'ws://localhost:3035', 'bam.nr-data.net'
  # policy.script_src :self, :https, :unsafe_inline, 'bam.nr-data.net', 'js-agent.newrelic.com'

  # default-src 'none';
  # img-src 'self' *.newrelic.com;
  # script-src 'self' *.newrelic.com 'unsafe-inline';
  # style-src 'self'
