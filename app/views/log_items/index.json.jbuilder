# frozen_string_literal: true

json.array! @log_items, partial: 'log_items/log_item', as: :log_item, locals: { vehicle: @vehicle }
