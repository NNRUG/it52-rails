# frozen_string_literal: true

class EventParticipationsController < ApplicationController
  respond_to :html
  load_and_authorize_resource param_method: :event_participation_params

  def create
    @event_participation.user = current_user || nil
    @event_participation.save!

    flash[:success] = t(:event_participation_created, title: @event_participation.event.title)
    if @event_participation.event.foreign_link.present?
      return redirect_to @event_participation.event.user_foreign_link(current_user)
    end

    redirect_back(fallback_location: root_path)
  end

  def destroy
    @event_participation.destroy!

    flash[:success] = t(:event_participation_canceled, title: @event_participation.event.title)
    redirect_back(fallback_location: root_path)
  end

  private

  def event_participation_params
    params.require(:event_participation).permit(:event_id)
  end
end
