# frozen_string_literal: true

class LineItem < ApplicationRecord
  belongs_to :log_item
  has_many :line_item_fields

  owner_from_parent :log_item, LogItem

  validate :type_exists

  scope :chrono, -> { includes(:log_item).order('log_items.performed_at asc') }
  scope :inverse_chrono, -> { includes(:log_item).order('log_items.performed_at desc') }
  scope :with_type, ->(type_id) { where(type_id:) }
  scope :with_field_value, lambda { |field_type|
    joins(:line_item_fields)
      .where(line_item_fields: { type_id: field_type })
      .where('line_item_fields.string_value IS NOT NULL OR line_item_fields.tire_set_value_id IS NOT NULL OR line_item_fields.boolean_value IS NOT NULL OR line_item_fields.decimal_value IS NOT NULL')
      .distinct(:id)
  }
  scope :where_field_value, lambda { |field_type, value|
    q = joins(:line_item_fields).where(line_item_fields: { type_id: field_type })
    case LineItemField.value_data_type(value)
    when :string
      q = q.where(line_item_fields: { string_value: value })
    when :tire_set
      q = q.where(line_item_fields: { tire_set_value_id: value.id })
    when :boolean
      q = q.where(line_item_fields: { boolean_value: value })
    when :decimal
      q = q.where(line_item_fields: { decimal_value: value })
    when nil
      q = q.where('line_item_fields.string_value IS NULL AND line_item_fields.tire_set_value IS NULL AND line_item_fields.boolean_value IS NULL AND line_item_fields.decimal_value IS NULL')
    else
      raise StandardError, 'Invalid data type for field value'
    end
    q.distinct(:id)
  }
  scope :where_vehicle, ->(vehicle) { joins(:log_item).where(log_items: { vehicle_id: vehicle.id }) }
  scope :where_after, ->(date) { joins(:log_item).where('log_items.performed_at > ?', date) }

  def type_exists
    errors.add(:type_id, "Type #{type_id} doesn't exist") unless type
  end

  def get_field(field_type)
    line_item_fields.with_type(field_type).first
  end

  def create_field(field_type, value = nil)
    field = LineItemField.create(line_item: self, type_id: field_type)
    field.value = value
    field
  end

  def get_field!(field_type)
    get_field(field_type) || create_field(field_type, get_default_field_value(field_type))
  end

  def get_default_field_value(field_type)
    type.default_field_value(field_type, self)
  end

  def get_field_value(field_type)
    get_field(field_type)&.value
  end

  def set_field_value!(field_type, value)
    field = get_field!(field_type)
    field.value = value
    field.save!
  end

  def destroy_field!(field_type)
    get_field(field_type)&.destroy!
  end

  delegate :vehicle, to: :log_item

  delegate :performed_at, to: :log_item

  delegate :odometer_reading, to: :log_item

  def type
    LineItemTypes::GLOBAL.get_type(type_id)
  end

  def type=(new_type)
    self.type_id = new_type.id
  end
end
