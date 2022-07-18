# frozen_string_literal: true

class Shop < ApplicationRecord
  has_many :log_items, dependent: :nullify
  belongs_to :owner, class_name: 'User', optional: false

  owner_from_record

  def gid_class_name
    'shop'
  end
end
