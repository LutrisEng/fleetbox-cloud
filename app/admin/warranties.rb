# frozen_string_literal: true

ActiveAdmin.register Warranty do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :miles, :months, :title, :vehicle_id, :tire_set_id, :uuid
  #
  # or
  #
  # permit_params do
  #   permitted = [:miles, :months, :title, :vehicle_id, :tire_set_id, :uuid]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
