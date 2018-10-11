class DropIndexUsersOnEmail < ActiveRecord::Migration
  def change
    remove_index :users, name: 'index_users_on_email'
  end
end
