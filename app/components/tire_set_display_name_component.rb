# frozen_string_literal: true

class TireSetDisplayNameComponent < ViewComponent::Base
  def initialize(tire_set:)
    super
    @tire_set = tire_set
  end
end
