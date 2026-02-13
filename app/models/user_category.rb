# frozen_string_literal: true

class UserCategory < ApplicationRecord
  belongs_to :user
  belongs_to :category
end
