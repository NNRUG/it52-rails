class My::UsersController < ApplicationController
  respond_to :html
  responders :flash

  before_action :set_user
  after_action :sync_with_mailchimp, only: :update

  def show
    @user = @user.decorate
    respond_with @user
  end

  def edit
    respond_with @user
  end

  def update
    location = @user.update(user_profile_params) ? my_profile_path : edit_my_profile_path
    respond_with @user, location: location
  end

  private

  def set_user
    @user = current_user
    authorize! :manage, @user
  end

  def user_profile_params
    params.require(:user).permit(:first_name, :last_name, :nickname, :employment,
                                 :website, :bio, :avatar_image, :avatar_image_cache, :subscription)
  end

  def sync_with_mailchimp
    attributes = %i(first_name last_name subscription)
    @user.reload
    @user.sync_with_mailchimp if attributes.any? { |attribute| @user.send(attribute) != user_profile_params[attribute] }
  end
end
