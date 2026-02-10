# frozen_string_literal: true

class EventCategory < ApplicationRecord
  belongs_to :event
  belongs_to :category
end
