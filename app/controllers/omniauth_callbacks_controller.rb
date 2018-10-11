class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  %i(facebook github twitter vkontakte google_oauth2).each do |provider|
    define_method provider do
      auth_for provider
    end
  end

  private

  def auth_for(kind)
    session['devise.oauth_data'] = nil
    @user = User.from_omniauth(auth_params, current_user)
    @authentication = @user.authentications.find do |a|
      a.uid == auth_params[:uid] && a.provider == auth_params[:provider]
    end

    if @user.persisted?
      set_flash_message(:notice, :success, kind: kind.to_s.capitalize) if is_navigational_format?
      sign_in_and_redirect @user, event: :authentication
    else
      session['devise.oauth_data'] = auth_params
      render 'devise/sessions/new', error: "Не получилось войти с помощью #{kind}."
    end
  end

  def auth_params
    request.env["omniauth.auth"].with_indifferent_access
  end
end
