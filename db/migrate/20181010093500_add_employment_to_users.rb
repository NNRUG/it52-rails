class AddEmploymentToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :employment, :string
  end
end
