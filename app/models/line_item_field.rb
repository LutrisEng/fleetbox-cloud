class LineItemField < ApplicationRecord
  belongs_to :line_item
  belongs_to :tire_set_value, class_name: 'TireSet', foreign_key: :tire_set_value_id, optional: true

  scope :with_type, ->(type_id) { where(type_id: type_id) }
end
