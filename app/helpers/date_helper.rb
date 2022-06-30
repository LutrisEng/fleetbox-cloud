# frozen_string_literal: true

module DateHelper
  def display_time(time, **options)
    I18n.l(displayable_time(time), **options) if time
  end
end
