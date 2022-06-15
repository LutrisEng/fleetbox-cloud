# frozen_string_literal: true

class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  has_many :vehicles, foreign_key: :owner_id, dependent: :destroy, inverse_of: :owner
  has_many :shops, foreign_key: :owner_id, dependent: :destroy, inverse_of: :owner
  has_many :tire_sets, foreign_key: :owner_id, dependent: :destroy, inverse_of: :owner

  def tz
    ActiveSupport::TimeZone.new(timezone)
  end

  def now
    Time.now(in: tz)
  end
end
