# frozen_string_literal: true

module Types
  class TireSetType < Types::BaseObject
    implements GraphQL::Types::Relay::Node

    def self.authorized?(object, context)
      super && TireSetPolicy.new(context[:current_user], object).show?
    end

    field :uuid, ID, null: false

    field :make, String
    field :model, String
    field :tin, String
    field :user_display_name, String

    field :vehicle_type, String
    field :width, Integer
    field :aspect_ratio, Integer
    field :construction, String
    field :diameter, Integer
    field :load_index, Integer
    field :speed_rating, String

    field :base_miles, Integer, null: false
    field :breakin, Integer

    field :hidden, Boolean

    field :owner, Types::UserType, null: false

    field :display_name, String
    field :odometer, Integer

    field :current_vehicle, Types::VehicleType

    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
