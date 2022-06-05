class LineItem < ApplicationRecord
  belongs_to :log_item
  has_many :line_item_fields

  scope :chrono, -> { includes(:log_item).order("log_items.performed_at asc") }
  scope :inverse_chrono, -> { includes(:log_item).order("log_items.performed_at desc") }
  scope :with_type, ->(type_id) { where(type_id: type_id) }
  scope :where_field_value, ->(field_type, value) {
    q = includes(:line_item_fields).where("line_item_fields.type_id = ?", field_type)
    if value.is_a? String
      q = q.where("line_item_fields.string_value = ?", value)
    elsif value.is_a? TireSet
      q = q.where("line_item_fields.tire_set_value_id = ?", value.id)
    else
      raise StandardError.new "Invalid type for field value"
    end
    q.distinct(:id)
  }
  scope :where_vehicle, ->(vehicle) { includes(:log_item).where("log_items.vehicle_id = ?", vehicle.id) }
  scope :where_after, ->(date) { includes(:log_item).where("log_items.performed_at > ?", date) }

  def get_field(field_type)
    line_item_fields.with_type(field_type).first
  end

  def get_field!(field_type)
    get_field(field_type) || LineItemField::create(line_item: self, type_id: field_type)
  end

  def get_field_value_string(field_type)
    get_field(field_type)&.string_value
  end

  def get_field_value_tire_set(field_type)
    get_field(field_type)&.tire_set_value
  end

  def get_field_value_boolean(field_type)
    get_field(field_type)&.boolean_value
  end

  def set_field_value!(field_type, value)
    field = get_field!(field_type)
    case value
    when String
      field.string_value = value
    when TireSet
      field.tire_set_value = value
    when true, false
      field.boolean_value = value
    else
      raise StandardError.new "Invalid type for field value"
    end
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
end
