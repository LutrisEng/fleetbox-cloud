class Warranty < ApplicationRecord
  belongs_to :vehicle
  belongs_to :tire_set
end
