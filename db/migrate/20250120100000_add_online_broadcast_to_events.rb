# frozen_string_literal: true

class AddOnlineBroadcastToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :online_broadcast, :string
  end
end
