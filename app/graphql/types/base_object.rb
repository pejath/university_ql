module Types
  class BaseObject < GraphQL::Schema::Object
    include Sources::LoaderMethods
    edge_type_class(Types::BaseEdge)
    connection_type_class(Types::BaseConnection)
    field_class Types::BaseField
    implements(GraphQL::Types::Relay::Node)
    global_id_field :id

  end
end
