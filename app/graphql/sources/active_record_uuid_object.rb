# frozen_string_literal: true

module Sources
  class ActiveRecordUuidObject < GraphQL::Dataloader::Source
    def initialize(model_class)
      super()
      @model_class = model_class
    end

    def fetch(ids)
      records = @model_class.where(uuid: ids)
      # return a list with `nil` for any ID that wasn't found
      ids.map { |id| records.find { |r| r.uuid == id } }
    end
  end
end
