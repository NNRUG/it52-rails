class EventBriefSerializer < ActiveModel::Serializer
  cache key: 'event', expires_in: 3.hours

  attributes :id, :title, :description, :image_url, :place, :started_at, :started_at_js, :location

  def image_url
    object.title_image.square_500.url
  end

  def started_at_js
    object.started_at.to_f * 1000
  end
end
