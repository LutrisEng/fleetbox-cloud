# frozen_string_literal: true

ActiveAdmin.register TireSet do
  controller do
    defaults finder: :find_by_uuid
  end
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :aspect_ratio, :base_miles, :breakin, :construction, :diameter, :hidden, :load_index, :make, :model, :speed_rating, :tin, :user_display_name, :vehicle_type, :width, :owner_id, :uuid
  #
  # or
  #
  # permit_params do
  #   permitted = [:aspect_ratio, :base_miles, :breakin, :construction, :diameter, :hidden, :load_index, :make, :model, :speed_rating, :tin, :user_display_name, :vehicle_type, :width, :owner_id, :uuid]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
