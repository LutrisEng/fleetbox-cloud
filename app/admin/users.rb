# frozen_string_literal: true

ActiveAdmin.register User do
  controller do
    defaults finder: :find_by_uuid
  end
end
