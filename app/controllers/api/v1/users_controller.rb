module Api
  module V1
    class UsersController < ApiController
      def show
        @response_object = User.find(params[:id])
        render render_options
      end
    end
  end
end
