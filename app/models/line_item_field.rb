class LineItemField < ApplicationRecord
  belongs_to :line_item
  belongs_to :tire_set_value, class_name: 'TireSet', foreign_key: :tire_set_value_id, optional: true

  validate :field_exists_for_line_item_type, :value_is_correct_type

  scope :with_type, ->(type_id) { where(type_id: type_id) }

  def type
    line_item.type.get_field(type_id)
  end

  def field_exists_for_line_item_type
    unless type
      errors.add(:type_id, "Field #{type_id} doesn't exist on line item type #{line_item.type.id}")
    end
  end

  def value_is_correct_type
    if type && (decimal_value != nil || string_value != nil || boolean_value != nil || tire_set_value != nil)
      case type.type
      when "string"
        if decimal_value != nil
          errors.add(:decimal_value, "decimal value set on string field")
        elsif boolean_value != nil
          errors.add(:boolean_value, "boolean value set on string field")
        elsif tire_set_value != nil
          errors.add(:tire_set_value, "tire set value set on string field")
        end
      when "tireSet"
        if decimal_value != nil
          errors.add(:decimal_value, "decimal value set on tire set field")
        elsif boolean_value != nil
          errors.add(:boolean_value, "boolean value set on tire set field")
        elsif string_value != nil
          errors.add(:string_value, "string value set on tire set field")
        end
      when "enum"
        if decimal_value != nil
          errors.add(:decimal_value, "decimal value set on enum field")
        elsif boolean_value != nil
          errors.add(:boolean_value, "boolean value set on enum field")
        elsif tire_set_value != nil
          errors.add(:tire_set_value, "tire set value set on enum field")
        elsif !type.enum_values.include?(string_value)
          errors.add(:string_value, "invalid value #{string_value} for enum with valid values #{type.enum_values.to_json}")
        end
      when "boolean"
        if decimal_value != nil
          errors.add(:decimal_value, "decimal value set on boolean field")
        elsif tire_set_value != nil
          errors.add(:tire_set_value, "tire set value set on boolean field")
        elsif string_value != nil
          errors.add(:string_value, "string value set on boolean field")
        end
      when "decimal"
        if boolean_value != nil
          errors.add(:boolean_value, "boolean value set on decimal field")
        elsif tire_set_value != nil
          errors.add(:tire_set_value, "tire set value set on decimal field")
        elsif string_value != nil
          errors.add(:string_value, "string value set on decimal field")
        end
      end
    end
  end
end
