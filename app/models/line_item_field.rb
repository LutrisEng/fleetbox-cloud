class LineItemField < ApplicationRecord
  belongs_to :line_item
  belongs_to :tire_set, foreign_key: :tire_set_value_id
end
