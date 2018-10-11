class My::AuthenticationsController < ApplicationController
  before_action :set_user_and_auth

  def destroy
    if @user.authentications.size == 1 && @user.email.blank?
      flash[:danger] = t('authentications.not_destroyed')
    else
      @authentication.destroy
      flash[:success] = t('authentications.destroyed', provider: @authentication.provider.capitalize)
    end
    redirect_to my_profile_path
  end

  private

  def set_user_and_auth
    @user = current_user
    @authentication = @user.authentications.find(params[:id])
  end
end
