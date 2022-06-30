# frozen_string_literal: true

ActiveAdmin.register LogItem do
  controller do
    defaults finder: :find_by_uuid
  end
  belongs_to :vehicle, finder: :find_by_uuid
  sidebar 'Data', only: %i[show edit] do
    ul do
      li link_to 'Line Items', admin_log_item_line_items_path(resource)
    end
  end
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :display_name, :include_time, :performed_at, :vehicle_id, :shop_id, :odometer_reading_id, :uuid
  #
  # or
  #
  # permit_params do
  #   permitted = [:display_name, :include_time, :performed_at, :vehicle_id, :shop_id, :odometer_reading_id, :uuid]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
