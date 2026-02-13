# frozen_string_literal: true

class AddPaidAndPriceToEvents < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :paid, :boolean, default: false, null: false
    add_column :events, :price, :integer
  end
end
