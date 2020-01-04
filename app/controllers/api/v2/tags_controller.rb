# frozen_string_literal: true

module Api
  module V2
    class TagsController < ApiController
      TAGS_PAGE_SIZE = 50

      def index
        @tags = ActsAsTaggableOn::Tag.order(taggings_count: :desc)
        if params[:q].present?
          @tags = @tags.where('name ILIKE ?', "#{params[:q].to_s.downcase}%")
        end
        options = { is_collection: true,
                    params: { action: action_name },
                    meta: { totalCount: @tags.count } }
        render json: ::V2::TagSerializer.new(@tags.limit(TAGS_PAGE_SIZE), options).serializable_hash
      end
    end
  end
end
