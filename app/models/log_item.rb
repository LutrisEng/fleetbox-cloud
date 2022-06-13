# frozen_string_literal: true

class LogItem < ApplicationRecord
  belongs_to :vehicle
  belongs_to :shop, optional: true
  belongs_to :odometer_reading, optional: true
  has_many :line_items

  scope :chrono, -> { order(performed_at: :asc) }
  scope :inverse_chrono, -> { order(performed_at: :desc) }
  scope :with_line_item_type, ->(type) { joins(:line_items).where(line_item: { type_id: type }).distinct(:id) }
  scope :with_owner, ->(owner) { joins(:vehicle).merge(Vehicle.with_owner(owner)) }

  def added_tire_sets
    TireSet.joins(line_item_fields: :line_item).merge(LineItem.where(type_id: 'mountedTires', log_item: self))
  end

  def removed_tire_sets
    TireSet.joins(line_item_fields: :line_item).merge(LineItem.where(type_id: 'dismountedTires', log_item: self))
  end
end
