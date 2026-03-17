class AddHiddenToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :hidden, :boolean, default: false, null: false unless column_exists?(:users, :hidden)
  end
end

