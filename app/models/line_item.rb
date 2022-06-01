class LineItem < ApplicationRecord
  belongs_to :log_item
  has_many :line_item_fields
end
