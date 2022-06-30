# frozen_string_literal: true

class TireSetComponent < ViewComponent::Base
  def initialize(tire_set:, current_user:, with_title: true)
    super
    @tire_set = tire_set
    @current_user = current_user
    @with_title = with_title
  end
end
