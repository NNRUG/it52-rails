# frozen_string_literal: true

class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  %i[facebook github twitter vkontakte google_oauth2].each do |provider|
    define_method provider do
      auth_for provider
    end
  end

  # Log OAuth failures (e.g. user denied, invalid_client) to console for debugging
  def failure
    kind = request.env['omniauth.error.type']
    reason = request.env['omniauth.error']&.message || request.params['message'] || 'unknown'
    msg = "[OmniAuth failure] provider=#{failed_strategy&.name || 'unknown'} kind=#{kind} reason=#{reason}"
    puts msg
    Rails.logger.warn msg if defined?(Rails.logger) && Rails.logger
    super
  end

  private

  def auth_for(kind)
    session['devise.oauth_data'] = nil
    auth = request.env['omniauth.auth']
    # Log VK (and other) callback for debugging authorization issues
    if auth
      msg = "[OmniAuth callback] provider=#{auth['provider']} uid=#{auth['uid']}"
      puts msg
      Rails.logger.info msg if defined?(Rails.logger) && Rails.logger
    else
      err = request.env['omniauth.error']
      err_msg = err ? "#{err.class}: #{err.message}" : 'no omniauth.auth'
      msg = "[OmniAuth callback] provider=#{kind} ERROR: #{err_msg}"
      puts msg
      Rails.logger.warn msg if defined?(Rails.logger) && Rails.logger
      return redirect_to new_user_session_path, alert: "Ошибка входа через #{kind}: #{err_msg}"
    end

    @user = User.from_omniauth(auth_params, current_user)
    @authentication = @user.authentications.find do |a|
      a.uid == auth_params[:uid] && a.provider == auth_params[:provider]
    end

    if @user.persisted?
      if is_navigational_format?
        set_flash_message(:notice, :success, kind: kind.to_s.capitalize)
      end
      sign_in_and_redirect @user, event: :authentication
    else
      msg = "[OmniAuth callback] provider=#{kind} user NOT persisted (validation/save failed)"
      puts msg
      Rails.logger.warn msg if defined?(Rails.logger) && Rails.logger
      session['devise.oauth_data'] = auth_params
      render 'devise/sessions/new', error: "Не получилось войти с помощью #{kind}."
    end
  end

  def auth_params
    request.env['omniauth.auth'].with_indifferent_access
  end
end
