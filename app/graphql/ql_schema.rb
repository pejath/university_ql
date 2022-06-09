
class QlSchema < GraphQL::Schema
  mutation(Types::MutationType)
  query(Types::QueryType)
  use(GraphQL::Dataloader)
  # For batch-loading (see https://graphql-ruby.org/dataloader/overview.html)
  # use GraphQL::Dataloader


  orphan_types(
    Types::Mark,
    Types::Group,
    Types::Faculty,
    Types::Lecture,
    Types::Student,
    Types::Subject,
    Types::Lecturer,
    Types::Department,
    Types::LectureTime,
    Types::LecturersSubjectType
  )
  # GraphQL-Ruby calls this when something goes wrong while running a query:
  def self.type_error(err, context)
    # if err.is_a?(GraphQL::InvalidNullError)
    #   # report to your bug tracker here
    #   return nil
    # end
    super
  end

  # Union and Interface Resolution
  def self.resolve_type(abstract_type, obj, ctx)
    # to return the correct GraphQL object type for `obj`
    raise(GraphQL::RequiredImplementationMissingError)
  end

  # Relay-style Object Identification:

  # Return a string UUID for `object`
  # def self.id_from_object(object, type_definition, query_ctx)
  #   # For example, use Rails' GlobalID library (https://github.com/rails/globalid):
  #   object_id = object.to_global_id.to_s
  #   # Remove this redundant prefix to make IDs shorter:
  #   object_id = object_id.sub("gid://#{GlobalID.app}/", "")
  #   encoded_id = Base64.urlsafe_encode64(object_id)
  #   # Remove the "=" padding
  #   encoded_id = encoded_id.sub(/=+/, "")
  #   # Add a type hint
  #   type_hint = type_definition.graphql_name.first
  #   "#{type_hint}_#{encoded_id}"
  # end
  #
  # # Given a string UUID, find the object
  # def self.object_from_id(encoded_id_with_hint, query_ctx)
  #   # For example, use Rails' GlobalID library (https://github.com/rails/globalid):
  #   # Split off the type hint
  #   _type_hint, encoded_id = encoded_id_with_hint.split("_", 2)
  #   # Decode the ID
  #   id = Base64.urlsafe_decode64(encoded_id)
  #   # Rebuild it for Rails then find the object:
  #   full_global_id = "gid://#{GlobalID.app}/#{id}"
  #   GlobalID::Locator.locate(full_global_id)
  # end
  #
  # def generate_global_id(entity_type, entity_id, query_ctx)
  #   scope = IDHasher.make_scope(entity_type)
  #   hashed_id = id_hasher(query_ctx.fetch(:hashing_salt)).encode(type: scope, id: entity_id)
  #
  #   URN::Mazepay.new_hashed_id(scope, hashed_id).to_urn
  # end
  #
  # def parse_global_id(id, query_ctx)
  #   urn = ::URN.parse(id)
  #
  #   # For now, always reject un-hashed IDs. This may become an environment or schema setting.
  #   # May be desirable to return this as an error or just `nil`?
  #   raise GraphQL::ExecutionError, "Entity ID not accepted." unless urn.hashed_id?
  #
  #   clear_ids = id_hasher(query_ctx.fetch(:hashing_salt)).decode(scope: urn.entity_type, hashed_id: urn.hashed_id)
  #   raise GraphQL::ExecutionError, "Invalid hash" if clear_ids.none?
  #
  #   clear_id = clear_ids.fetch(0)
  #
  #   URN::Mazepay.new_clear_id(urn.entity_type, clear_id)
  # rescue URN::ParseError => ex
  #   raise GraphQL::ExecutionError, ex.message
  # end
  #
  # private
  #
  # def id_hasher(hashing_salt)
  #   IDHasher.new(hashing_salt)
  # end

  def id_from_object(object, _type_definition, query_ctx)
    generate_global_id(object.class.name.to_s, object.id, query_ctx)
  end

  # Given a string global id, find the object
  def object_from_id(id, query_ctx)
    # If field field type is a `Types::GlobalID`, then it gets parsed before arriving here.
    # Only `ID` fields need to be parsed from a string into a URN.
    urn = if id.is_a?(::URN::Generic)
            id
          else
            parse_global_id(id, query_ctx)
          end

    urn.entity_class.find_by(id: urn.entity_id)
  end

  def generate_global_id(entity_type, entity_id, query_ctx)
    scope = IDHasher.make_scope(entity_type)
    hashed_id = id_hasher(query_ctx.fetch(:hashing_salt)).encode(type: scope, id: entity_id)

    URN::Mazepay.new_hashed_id(scope, hashed_id).to_urn
  end

  # Given a global ID (URN), decode the ID and create a new URN with the clear ID.
  def parse_global_id(id, query_ctx)
    urn = ::URN.parse(id)

    # For now, always reject un-hashed IDs. This may become an environment or schema setting.
    # May be desirable to return this as an error or just `nil`?
    raise GraphQL::ExecutionError, "Entity ID not accepted." unless urn.hashed_id?

    clear_ids = id_hasher(query_ctx.fetch(:hashing_salt)).decode(scope: urn.entity_type, hashed_id: urn.hashed_id)
    raise GraphQL::ExecutionError, "Invalid hash" if clear_ids.none?

    clear_id = clear_ids.fetch(0)

    URN::Mazepay.new_clear_id(urn.entity_type, clear_id)
  rescue URN::ParseError => ex
    raise GraphQL::ExecutionError, ex.message
  end

  private

  def id_hasher(hashing_salt)
    IDHasher.new(hashing_salt)
  end
end

