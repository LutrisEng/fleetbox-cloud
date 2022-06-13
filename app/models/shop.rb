# frozen_string_literal: true

class Shop < ApplicationRecord
  has_many :log_items
  belongs_to :owner, class_name: 'User', optional: false

  scope :with_owner, ->(owner) { where(owner:) }
end
