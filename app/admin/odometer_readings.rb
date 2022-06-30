# frozen_string_literal: true

ActiveAdmin.register OdometerReading do
  controller do
    defaults finder: :find_by_uuid
  end
  belongs_to :vehicle, finder: :find_by_uuid
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :performed_at, :include_time, :reading, :vehicle_id, :uuid
  #
  # or
  #
  # permit_params do
  #   permitted = [:performed_at, :include_time, :reading, :vehicle_id, :uuid]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
