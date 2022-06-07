class LineItem < ApplicationRecord
  belongs_to :log_item
  has_many :line_item_fields

  validate :type_exists

  scope :chrono, -> { includes(:log_item).order("log_items.performed_at asc") }
  scope :inverse_chrono, -> { includes(:log_item).order("log_items.performed_at desc") }
  scope :with_type, ->(type_id) { where(type_id: type_id) }
  scope :with_field_value, ->(field_type) {
    includes(:line_item_fields)
      .where("line_item_fields.type_id = ? && (line_item_fields.string_value IS NOT NULL OR line_item_fields.tire_set_value_id IS NOT NULL OR line_item_fields.boolean_value IS NOT NULL OR line_item_fields.decimal_value IS NOT NULL)", field_type)
      .distinct(:id)
  }
  scope :where_field_value, ->(field_type, value) {
    q = includes(:line_item_fields).where("line_item_fields.type_id = ?", field_type)
    case value
    when String
      q = q.where("line_item_fields.string_value = ?", value)
    when TireSet
      q = q.where("line_item_fields.tire_set_value_id = ?", value.id)
    when true, false
      q = q.where("line_item_fields.boolean_value = ?", value)
    when Numeric
      q = q.where("line_item_fields.decimal_value = ?", value)
    else
      raise StandardError.new "Invalid type for field value"
    end
    q.distinct(:id)
  }
  scope :where_vehicle, ->(vehicle) { includes(:log_item).where("log_items.vehicle_id = ?", vehicle.id) }
  scope :where_after, ->(date) { includes(:log_item).where("log_items.performed_at > ?", date) }

  def type_exists
    unless type
      errors.add(:type_id, "Type #{type_id} doesn't exist")
    end
  end

  def get_field(field_type)
    line_item_fields.with_type(field_type).first
  end

  def create_field(field_type, value = nil)
    field = LineItemField::create(line_item: self, type_id: field_type)
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

  def vehicle
    log_item.vehicle
  end

  def performed_at
    log_item.performed_at
  end

  def odometer_reading
    log_item.odometer_reading
  end

  def type
    LineItemTypes::GLOBAL.get_type(type_id)
  end

  def type=(t)
    type_id = t.id
  end
end
