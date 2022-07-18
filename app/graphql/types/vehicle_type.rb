# frozen_string_literal: true

module Types
  class VehicleType < Types::BaseObject
    implements GraphQL::Types::Relay::Node

    def self.authorized?(object, context)
      super && VehiclePolicy.new(context[:current_user], object).show?
    end

    field :uuid, ID, null: false
    field :model_year, String
    field :make, String
    field :model, String
    field :vin, String

    field :owner, Types::UserType, null: false

    field :user_display_name, String
    field :breakin, Integer
    field :miles_per_year, Integer

    field :odometer, Integer
    field :display_name, String

    field :current_tires, Types::TireSetType

    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
