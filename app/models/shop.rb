# frozen_string_literal: true

class Shop < ApplicationRecord
  has_many :log_items
end
