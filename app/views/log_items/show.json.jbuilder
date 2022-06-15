# frozen_string_literal: true

json.partial! 'log_items/log_item', log_item: @log_item, locals: { vehicle: @vehicle }
