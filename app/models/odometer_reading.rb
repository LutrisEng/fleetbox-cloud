class OdometerReading < ApplicationRecord
  belongs_to :vehicle
  has_one :log_item

  scope :chrono, -> { order(performed_at: :asc) }
  scope :inverse_chrono, -> { order(performed_at: :desc) }
  scope :closest_to, ->(date) { order("abs(performed_at - ?) asc", date).first }
  scope :first_before, ->(date) { where("performed_at < ?", date).inverse_chrono.first }
  scope :soonest_after, ->(date) { where("performed_at > ?", date).chrono.first }
end
