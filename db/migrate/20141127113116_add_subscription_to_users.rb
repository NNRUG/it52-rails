class AddSubscriptionToUsers < ActiveRecord::Migration
  def change
    add_column :users, :subscription, :boolean
  end
end
