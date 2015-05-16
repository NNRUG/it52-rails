module Api
  module V1
    class EventsController < ApiController
      load_and_authorize_resource

      before_action :prepare_model

      def index
        year = params[:year].present? ? params[:year].to_i : Time.now.year
        @response_object = @model.held_in(year)
        render render_options
      end

      def show
        @response_object = @model.find(params[:id])
        render render_options
      end

      private

      def prepare_model
        @model = Event.includes(:participants, participants: :authentications)
      end
    end
  end
end
