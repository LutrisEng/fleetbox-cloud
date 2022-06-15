# frozen_string_literal: true

json.array! @odometer_readings, partial: 'odometer_readings/odometer_reading', as: :odometer_reading
