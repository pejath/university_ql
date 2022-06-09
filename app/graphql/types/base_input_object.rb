module Types
  class BaseInputObject < GraphQL::Schema::InputObject
    argument_class Types::BaseArgument
    argument :data_source_id, Types::GlobalID, required: true
  end
end
