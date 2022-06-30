# frozen_string_literal: true

ActiveAdmin.register LineItem do
  controller do
    defaults finder: :find_by_uuid
  end
  belongs_to :log_item, finder: :find_by_uuid
  sidebar 'Data', only: %i[show edit] do
    ul do
      li link_to 'Fields', admin_line_item_line_item_fields_path(resource)
    end
  end
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :notes, :sort_order, :type_id, :log_item_id, :uuid
  #
  # or
  #
  # permit_params do
  #   permitted = [:notes, :sort_order, :type_id, :log_item_id, :uuid]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
