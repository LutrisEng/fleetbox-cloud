class LogItem < ApplicationRecord
  belongs_to :vehicle
  belongs_to :shop
  belongs_to :odometer_reading
  has_many :line_items
end
