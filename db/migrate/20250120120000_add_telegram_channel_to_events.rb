# frozen_string_literal: true

class AddTelegramChannelToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :telegram_channel, :string
  end
end
