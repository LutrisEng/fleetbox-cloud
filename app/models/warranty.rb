# frozen_string_literal: true

class Warranty < ApplicationRecord
  belongs_to :vehicle, optional: true
  belongs_to :tire_set, optional: true
end
