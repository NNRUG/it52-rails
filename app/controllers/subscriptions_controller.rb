# frozen_string_literal: true

class SubscriptionsController < ApplicationController
  skip_before_action :authenticate_user!, only: :unsubscribe

  def unsubscribe
    user = User.find_signed(params[:token], purpose: :unsubscribe)

    if user
      user.update(subscription: false)
      flash[:notice] = t('subscriptions.unsubscribe.success', default: 'Вы отписались от уведомлений о новых мероприятиях.')
    else
      flash[:alert] = t('subscriptions.unsubscribe.invalid', default: 'Ссылка для отписки недействительна или устарела.')
    end

    redirect_to root_path
  end
end

