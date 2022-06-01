class OdometerReading < ApplicationRecord
  belongs_to :vehicle
  has_one :log_item
end
