# frozen_string_literal: true

class AlertComponent < ViewComponent::Base
  COLORS = %w[primary secondary success danger warning info light dark].freeze

  def initialize(color: :primary, dismissible: false)
    super
    @color = color
    @dismissible = dismissible
  end

  def div_classes
    if @dismissible
      "alert alert-#{@color} alert-dismissible fade show"
    else
      "alert alert-#{@color}"
    end
  end
end
