# frozen_string_literal: true

module Types
  # Base class to use for types that are backed by an ActiveRecord model.
  # For types not backed by a database record, use `BaseObject`
  class BaseRecordObject < BaseObject
    implements(GraphQL::Types::Relay::Node)

    # Default Pundit policy action used to authorise viewing a record

    global_id_field :id

    # def id
    #   QlSchema.id_from_object(object)
    # end

  end
end
