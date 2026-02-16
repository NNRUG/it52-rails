# frozen_string_literal: true

class AddParticipantsLimitToEvents < ActiveRecord::Migration[5.2]
  def up
    add_column :events, :registration_limit_enabled, :boolean, default: false, null: false unless column_exists?(:events, :registration_limit_enabled)
    add_column :events, :participants_limit, :integer unless column_exists?(:events, :participants_limit)
  end

  def down
    remove_column :events, :participants_limit if column_exists?(:events, :participants_limit)
    remove_column :events, :registration_limit_enabled if column_exists?(:events, :registration_limit_enabled)
  end
end
