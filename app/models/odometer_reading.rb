# frozen_string_literal: true

class OdometerReading < ApplicationRecord
  belongs_to :vehicle
  has_one :log_item, dependent: :nullify

  owner_from_parent :vehicle, Vehicle

  scope :chrono, -> { order(performed_at: :asc) }
  scope :inverse_chrono, -> { order(performed_at: :desc) }
  scope :order_by_closest_to, lambda { |date|
    order(ArelHelpers.abs(ArelHelpers.date_part('epoch', performed_at - ArelHelpers.to_timestamp(date))).asc)
  }
  scope :closest_to, ->(date) { order_by_closest_to(date).first }
  scope :first_before, ->(date) { where('performed_at < ?', date).inverse_chrono.first }
  scope :soonest_after, ->(date) { where('performed_at > ?', date).chrono.first }
end
