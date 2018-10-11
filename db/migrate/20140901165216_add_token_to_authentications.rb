class AddTokenToAuthentications < ActiveRecord::Migration
  def change
    add_column :authentications, :token, :string
    add_column :authentications, :token_expires, :datetime
  end
end
