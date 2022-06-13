# frozen_string_literal: true

class User < ApplicationRecord
  validates :email, presence: true
  validates :email, uniqueness: true
  has_many :vehicles, foreign_key: :owner_id
  has_many :shops, foreign_key: :owner_id
  has_many :tire_sets, foreign_key: :owner_id
end
