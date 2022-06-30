# frozen_string_literal: true

ActiveAdmin.register LineItemField do
  controller do
    defaults finder: :find_by_uuid
  end
  belongs_to :line_item, finder: :find_by_uuid
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :decimal_value, :string_value, :boolean_value, :type_id, :line_item_id, :tire_set_value_id, :uuid
  #
  # or
  #
  # permit_params do
  #   permitted = [:decimal_value, :string_value, :boolean_value, :type_id, :line_item_id, :tire_set_value_id, :uuid]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
