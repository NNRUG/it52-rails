class AddPointToEvents < ActiveRecord::Migration
  def change
    add_column :events, :location, :point, geographic: true
  end
end
