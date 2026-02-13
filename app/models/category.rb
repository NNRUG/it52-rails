# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :event_categories, dependent: :destroy
  has_many :events, through: :event_categories
  has_many :user_categories, dependent: :destroy
  has_many :users, through: :user_categories

  validates :name, presence: true, uniqueness: true
end
