class TireSet < ApplicationRecord
  has_many :line_item_fields

  def line_items
    LineItem.joins(:line_item_fields).where("line_item_fields.tire_set_value_id = ?", id).distinct
  end
end
