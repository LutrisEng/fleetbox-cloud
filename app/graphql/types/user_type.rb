# frozen_string_literal: true

module Types
  class UserType < Types::BaseObject
    implements GraphQL::Types::Relay::Node

    def self.authorized?(object, context)
      super && UserPolicy.new(context[:current_user], object).show?
    end

    field :uuid, ID, null: false
    field :name, String
    field :email, String, null: false

    field :timezone, String, null: false

    field :admin, Boolean, null: false
    field :paid, Boolean, null: false
    field :max_vehicles, Integer, null: false

    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
