# frozen_string_literal: true

ActiveAdmin.register Vehicle do
  controller do
    defaults finder: :find_by_uuid
  end
  sidebar 'Data', only: %i[show edit] do
    ul do
      li link_to 'Log Items', admin_vehicle_log_items_path(resource)
    end
  end
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :breakin, :user_display_name, :make, :miles_per_year, :model, :vin, :model_year, :owner_id, :uuid
  #
  # or
  #
  # permit_params do
  #   permitted = [:breakin, :user_display_name, :make, :miles_per_year, :model, :vin, :model_year, :owner_id, :uuid]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
