class AddDeviseToUsers < ActiveRecord::Migration
  def self.up
    change_table(:users) do |t|
      ## Recoverable
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.inet     :current_sign_in_ip
      t.inet     :last_sign_in_ip

      ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at


      # Uncomment below if timestamps were not included in your original model.
      # t.timestamps
    end

    # Migrate from Sorcery columns to Devise
    change_column :users, :email, :string, null: false, default: ""

    rename_column :users, :crypted_password, :encrypted_password
    change_column :users, :encrypted_password, :string, null: false, default: "", limit: 128

    rename_column :users, :salt, :password_salt
    change_column :users, :password_salt, :string, default: "", null: false

    add_index :users, :confirmation_token,   unique: true
    # add_index :users, :unlock_token,         unique: true


    # Clean up Sorcery columns
    remove_column :users, :remember_me_token
    remove_column :users, :remember_me_token_expires_at
    remove_column :users, :reset_password_token_expires_at
    remove_column :users, :reset_password_email_sent_at
    remove_column :users, :last_login_at
    remove_column :users, :last_logout_at
    remove_column :users, :last_activity_at
    remove_column :users, :last_login_from_ip_address
  end

  def self.down
    # By default, we don't want to make any assumption about how to roll back a migration when your
    # model already existed. Please edit below which fields you would like to remove in this migration.
    raise ActiveRecord::IrreversibleMigration
  end
end
