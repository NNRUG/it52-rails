class RenameUsersNameToNickname < ActiveRecord::Migration
  def change
    rename_column :users, :name, :nickname
    change_column :users, :nickname, :string, uniq: true, index: true, default: ''
  end
end
