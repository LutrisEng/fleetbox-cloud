# frozen_string_literal: true

ActiveAdmin.register Shop do
  controller do
    defaults finder: :find_by_uuid
  end
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :email, :location, :name, :notes, :phone_number, :url, :owner_id, :uuid
  #
  # or
  #
  # permit_params do
  #   permitted = [:email, :location, :name, :notes, :phone_number, :url, :owner_id, :uuid]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
