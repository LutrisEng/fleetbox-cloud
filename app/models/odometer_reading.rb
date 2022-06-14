# frozen_string_literal: true

class OdometerReading < ApplicationRecord
  belongs_to :vehicle
  has_one :log_item, dependent: :nullify
  validate :consistent_performed_at

  owner_from_parent :vehicle, Vehicle

  def consistent_performed_at
    return unless log_item && log_item.performed_at != performed_at

    errors.add(:performed_at, 'Odometer reading performed at different timestamp than log item')
  end

  def attach_to_log_item(log_item)
    self.log_item = log_item
    self.performed_at = log_item.performed_at
  end

  scope :chrono, -> { order(performed_at: :asc) }
  scope :inverse_chrono, -> { order(performed_at: :desc) }
  scope :order_by_closest_to, lambda { |date|
    order(ArelHelpers.abs(ArelHelpers.date_part('epoch', performed_at - ArelHelpers.to_timestamp(date))).asc)
  }
  scope :closest_to, ->(date) { order_by_closest_to(date).first }
  scope :first_before, ->(date) { where('performed_at < ?', date).inverse_chrono.first }
  scope :soonest_after, ->(date) { where('performed_at > ?', date).chrono.first }
end
