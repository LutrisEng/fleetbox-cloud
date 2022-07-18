# frozen_string_literal: true

class FleetboxCloudSchema < GraphQL::Schema
  mutation(Types::MutationType)
  query(Types::QueryType)

  # For batch-loading (see https://graphql-ruby.org/dataloader/overview.html)
  use GraphQL::Dataloader

  # GraphQL-Ruby calls this when something goes wrong while running a query:

  # Union and Interface Resolution
  def self.resolve_type(_abstract_type, obj, _ctx)
    case obj
    when Vehicle
      Types::VehicleType
    when User
      Types::UserType
    when TireSet
      Types::TireSetType
    else
      raise StandardError, "Unexpected object: #{obj}"
    end
  end

  # Relay-style Object Identification:

  # Return a string UUID for `object`
  def self.id_from_object(object, _type_definition, _query_ctx)
    object.gid
  end

  # Given a string UUID, find the object
  def self.object_from_id(global_id, _query_ctx)
    ApplicationRecord.find_gid(global_id)
  end
end
