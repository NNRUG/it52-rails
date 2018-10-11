module Api
  class ApiController < ActionController::Base
    #before_action :authenticate_with_basic
    before_action :set_default_options
    before_action :set_allow_cors_headers

    protected

    def callback
      params[:callback]
    end

    def set_allow_cors_headers
      headers['Access-Control-Allow-Origin']    = '*'
      headers['Access-Control-Allow-Methods']   = 'GET'
      headers['Access-Control-Request-Method']  = 'OPTIONS'
      headers['Access-Control-Allow-Headers']   = 'Content-Type'
    end

    def set_default_options
      @default_options =  { root: false }
    end

    def render_options
      @default_options.merge! json: @response_object
      callback.present? ? @default_options.merge(callback: callback) : @default_options
    end
  end
end
