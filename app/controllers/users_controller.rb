# frozen_string_literal: true

class UsersController < ApplicationController
  respond_to :html

  before_action :authenticate_user!, only: :show

  def index
    scope = current_user&.admin? ? User.all : User.visible
    @users = scope.order(:slug).page(params[:page])
    set_meta_tags noindex: true, follow: true
  end

  def show
    @user = User.friendly.find(params[:id])
    unless current_user&.admin? || !@user.hidden?
      return redirect_to root_path, alert: I18n.t('users.hidden_profile', default: 'Профиль недоступен для просмотра.')
    end
    @user = @user.decorate
    @owned_events = @user.owner_of_events.visible_by_user(current_user)
    @attended_events = @user.member_in_events.visible_by_user(current_user)
    set_meta_tags noindex: true, follow: true
    respond_with @user
  end
end
