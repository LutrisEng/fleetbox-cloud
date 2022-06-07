class LineItemField < ApplicationRecord
  belongs_to :line_item
  belongs_to :tire_set_value, class_name: 'TireSet', foreign_key: :tire_set_value_id, optional: true

  validate :field_exists_for_line_item_type

  scope :with_type, ->(type_id) { where(type_id: type_id) }

  def type
    line_item.type.get_field(type_id)
  end

  def field_exists_for_line_item_type
    unless type
      errors.add(:type_id, "Field #{type_id} doesn't exist on line item type #{line_item.type.id}")
    end
  end
end
