class LineItemField < ApplicationRecord
  belongs_to :line_item
  belongs_to :tire_set_value, class_name: 'TireSet', foreign_key: :tire_set_value_id, optional: true

  validate :field_exists_for_line_item_type, :ensure_only_one_value_is_set, :value_is_correct_type

  scope :with_type, ->(type_id) { where(type_id: type_id) }

  def type
    line_item.type.get_field(type_id)
  end
  
  def data_type
    type.type
  end

  def value
    case data_type
    when "string", "enum"
      string_value
    when "tireSet"
      tire_set_value
    when "boolean"
      boolean_value
    when "decimal"
      decimal_value
    end
  end

  def value=(new_value)
    string_value = new_value
    case new_value
    when String
      if data_type != "string" && data_type != "enum"
        raise StandardError.new "Invalid value for #{data_type.inspect} field: #{new_value.inspect}"
      end
      self.string_value = new_value
    when TireSet
      if data_type != "tireSet"
        raise StandardError.new "Invalid value for tire set field: #{new_value.inspect}"
      end
      self.tire_set_value = new_value
    when true, false
      if data_type != "boolean"
        raise StandardError.new "Invalid value for boolean field: #{new_value.inspect}"
      end
      self.boolean_value = new_value
    when Numeric
      if data_type != "decimal"
        raise StandardError.new "Invalid value for decimal field: #{new_value.inspect}"
      end
      self.decimal_value = new_value
    when nil
      self.string_value = nil
      self.tire_set_value = nil
      self.boolean_value = nil
      self.decimal_value = nil
    else
      raise StandardError.new "Invalid type for field value: #{new_value.inspect}"
    end
  end

  def field_exists_for_line_item_type
    unless type
      errors.add(:type_id, "Field #{type_id} doesn't exist on line item type #{line_item.type.id}")
    end
  end

  def value_is_set
    decimal_value != nil || string_value != nil || boolean_value != nil || tire_set_value != nil
  end

  def only_one_value_is_set
    !value_is_set || ((decimal_value != nil) ^ (string_value != nil) ^ (boolean_value != nil) ^ (tire_set_value != nil))
  end

  def ensure_only_one_value_is_set
    unless only_one_value_is_set
      errors.add(:value, "more than one value field is set")
    end
  end

  def value_is_correct_type
    if type && value_is_set
      case data_type
      when "string"
        if decimal_value != nil
          errors.add(:decimal_value, "decimal value set on string field")
        end
        if boolean_value != nil
          errors.add(:boolean_value, "boolean value set on string field")
        end
        if tire_set_value != nil
          errors.add(:tire_set_value, "tire set value set on string field")
        end
      when "tireSet"
        if decimal_value != nil
          errors.add(:decimal_value, "decimal value set on tire set field")
        end
        if boolean_value != nil
          errors.add(:boolean_value, "boolean value set on tire set field")
        end
        if string_value != nil
          errors.add(:string_value, "string value set on tire set field")
        end
      when "enum"
        if decimal_value != nil
          errors.add(:decimal_value, "decimal value set on enum field")
        end
        if boolean_value != nil
          errors.add(:boolean_value, "boolean value set on enum field")
        end
        if tire_set_value != nil
          errors.add(:tire_set_value, "tire set value set on enum field")
        end
        if !type.enum_values.include?(string_value)
          errors.add(:string_value, "invalid value #{string_value} for enum with valid values #{type.enum_values.to_json}")
        end
      when "boolean"
        if decimal_value != nil
          errors.add(:decimal_value, "decimal value set on boolean field")
        end
        if tire_set_value != nil
          errors.add(:tire_set_value, "tire set value set on boolean field")
        end
        if string_value != nil
          errors.add(:string_value, "string value set on boolean field")
        end
      when "decimal"
        if boolean_value != nil
          errors.add(:boolean_value, "boolean value set on decimal field")
        end
        if tire_set_value != nil
          errors.add(:tire_set_value, "tire set value set on decimal field")
        end
        if string_value != nil
          errors.add(:string_value, "string value set on decimal field")
        end
      end
    end
  end
end
