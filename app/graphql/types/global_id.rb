# frozen_string_literal: true

module Types
  # This duplicates some logic from the relay/global_id implementation of the
  # graphql-ruby gem. Ideally these would be unified and we'd replace the ID type.
  class GlobalID < Types::BaseScalar
    description "A URN that globally identifies an object by including its type and ID"

    class << self
      def coerce_input(input_value, context)
        context.schema.parse_global_id(input_value, context)
      rescue URN::ParseError => ex
        raise GraphQL::CoercionError, ex.message
      end

      def coerce_result(object, context)
        # If the input is a String, assume it was manually converted to a GlobalID
        return object if object.is_a?(::String)

        context.schema.id_from_object(object)
      end
    end
  end
end
