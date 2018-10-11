class AddForeignLinkToEvent < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :foreign_link, :text
  end
end
