module Api
  module V1
    class UsersController < ApiController
      # resource_description do
      #   short 'Участники'
      #   formats ['json']
      #   param :id, /\d+/, desc: "User ID", required: true
      #   api_version "v1"
      #   api_base_url 'api/v1/users'
      # end

      # api :GET, '/:id', 'Получить данные пользователя'
      def show
        @response_object = User.find(params[:id])
        render render_options
      end
    end
  end
end
