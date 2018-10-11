# coding: utf-8
module Api
  module V1
    class EventsController < ApiController
      load_and_authorize_resource

      before_action :prepare_model

      # resource_description do
      #   short 'События'
      #   formats ['json']
      #   api_version "v1"
      #   api_base_url 'api/v1/events'
      # end

      # api :GET, '/', 'Получить список событий за текущий год'
      # api :GET, '/in/:year', 'Получить список событий за указанный год'
      # param :year,  /\d{4}/, desc: "Year", required: false
      def index
        year  = params[:year].present?  ? params[:year].to_i  : Time.now.year
        month = params[:month].present? ? params[:month].to_i : nil
        @response_object = @model.published.held_in(year, month)
        render render_options
      end

      # api :GET, '/:id', 'Получить информацию по событию'
      # param :id, /\d+/, desc: "Event ID", required: true
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
