# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :me, Types::UserType, description: 'The currently logged-in user'
    def me
      context[:current_user]
    end

    field :vehicles, [Types::VehicleType], null: false, description: 'A list of every vehicle visible to this user'
    def vehicles
      VehiclePolicy::Scope.new(context[:current_user], Vehicle).resolve
    end

    field :vehicle, Types::VehicleType, description: 'A single vehicle by UUID' do
      argument :uuid, ID, description: "The vehicle's UUID"
    end
    def vehicle(uuid:)
      dataloader.with(Sources::ActiveRecordUuidObject, Vehicle).load(uuid)
    end

    field :tire_sets, [Types::VehicleType], null: false, description: 'A list of every tire set visible to this user'
    def tire_sets
      TireSetPolicy::Scope.new(context[:current_user], TireSet).resolve
    end

    field :tire_set, Types::VehicleType, description: 'A single tire set by UUID' do
      argument :uuid, ID, description: "The tire set's UUID"
    end
    def tire_set(uuid:)
      dataloader.with(Sources::ActiveRecordUuidObject, TireSet).load(uuid)
    end
  end
end
