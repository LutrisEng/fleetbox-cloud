module DateHelper
  def display_time(time, **options)
    I18n.l(displayable_time(time), **options) if time
  end
end
