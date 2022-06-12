# frozen_string_literal: true

class LineItemField < ApplicationRecord
  belongs_to :line_item
  belongs_to :tire_set_value, class_name: 'TireSet', optional: true

  validate :field_exists_for_line_item_type, :ensure_only_one_value_is_set, :value_is_correct_type

  scope :with_type, ->(type_id) { where(type_id:) }

  def type
    line_item.type.get_field(type_id)
  end

  def data_type
    type.type
  end

  def self.value_data_type(value)
    case value
    when String
      :string
    when TireSet
      :tire_set
    when true, false
      :boolean
    when Numeric
      :decimal
    when nil
      nil
    else
      raise StandardError, "Invalid type for field value: #{new_value.inspect}"
    end
  end

  def value
    case data_type
    when 'string', 'enum'
      string_value
    when 'tireSet'
      tire_set_value
    when 'boolean'
      boolean_value
    when 'decimal'
      decimal_value
    end
  end

  def value=(new_value)
    case LineItemField.value_data_type(new_value)
    when :string
      if data_type != 'string' && data_type != 'enum'
        raise StandardError, "Invalid value for #{data_type.inspect} field: #{new_value.inspect}"
      end

      self.string_value = new_value
    when :tire_set
      raise StandardError, "Invalid value for tire set field: #{new_value.inspect}" if data_type != 'tireSet'

      self.tire_set_value = new_value
    when :boolean
      raise StandardError, "Invalid value for boolean field: #{new_value.inspect}" if data_type != 'boolean'

      self.boolean_value = new_value
    when :decimal
      raise StandardError, "Invalid value for decimal field: #{new_value.inspect}" if data_type != 'decimal'

      self.decimal_value = new_value
    when nil
      self.string_value = nil
      self.tire_set_value = nil
      self.boolean_value = nil
      self.decimal_value = nil
    end
  end

  def field_exists_for_line_item_type
    errors.add(:type_id, "Field #{type_id} doesn't exist on line item type #{line_item.type.id}") unless type
  end

  def value_is_set
    !decimal_value.nil? || !string_value.nil? || !boolean_value.nil? || !tire_set_value.nil?
  end

  def only_one_value_is_set
    !value_is_set || ((!decimal_value.nil?) ^ (!string_value.nil?) ^ (!boolean_value.nil?) ^ (!tire_set_value.nil?))
  end

  def ensure_only_one_value_is_set
    errors.add(:value, 'more than one value field is set') unless only_one_value_is_set
  end

  def value_is_correct_type
    if type && value_is_set
      case data_type
      when 'string'
        errors.add(:decimal_value, 'decimal value set on string field') unless decimal_value.nil?
        errors.add(:boolean_value, 'boolean value set on string field') unless boolean_value.nil?
        errors.add(:tire_set_value, 'tire set value set on string field') unless tire_set_value.nil?
      when 'tireSet'
        errors.add(:decimal_value, 'decimal value set on tire set field') unless decimal_value.nil?
        errors.add(:boolean_value, 'boolean value set on tire set field') unless boolean_value.nil?
        errors.add(:string_value, 'string value set on tire set field') unless string_value.nil?
      when 'enum'
        errors.add(:decimal_value, 'decimal value set on enum field') unless decimal_value.nil?
        errors.add(:boolean_value, 'boolean value set on enum field') unless boolean_value.nil?
        errors.add(:tire_set_value, 'tire set value set on enum field') unless tire_set_value.nil?
        unless type.enum_values.include?(string_value)
          errors.add(:string_value,
                     "invalid value #{string_value} for enum with valid values #{type.enum_values.to_json}")
        end
      when 'boolean'
        errors.add(:decimal_value, 'decimal value set on boolean field') unless decimal_value.nil?
        errors.add(:tire_set_value, 'tire set value set on boolean field') unless tire_set_value.nil?
        errors.add(:string_value, 'string value set on boolean field') unless string_value.nil?
      when 'decimal'
        errors.add(:boolean_value, 'boolean value set on decimal field') unless boolean_value.nil?
        errors.add(:tire_set_value, 'tire set value set on decimal field') unless tire_set_value.nil?
        errors.add(:string_value, 'string value set on decimal field') unless string_value.nil?
      end
    end
  end
end
