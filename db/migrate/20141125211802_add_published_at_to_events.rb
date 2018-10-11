class AddPublishedAtToEvents < ActiveRecord::Migration
  def change
    add_column :events, :published_at, :datetime

    Event.published.each do |event|
      publish_time = event.past? ? event.created_at : Time.now
      event.update(published_at: publish_time)
    end
  end
end
