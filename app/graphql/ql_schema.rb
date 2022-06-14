
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
  def self.resolve_type(_abstract_type, obj, ctx)
    "Types::#{obj.class.base_class.name}".constantize
  end

  def self.id_from_object(object,_type_definition, query_ctx)
    generate_global_id(object.class.name.to_s, object.id)
  end

  # Given a string global id, find the object
  def self.object_from_id(id, query_ctx)
    # If field field type is a `Types::GlobalID`, then it gets parsed before arriving here.
    # Only `ID` fields need to be parsed from a string into a URN.
    urn = if id.is_a?(::URN::Generic)
            id
          else
            parse_global_id(id)
          end

    urn.entity_class.find_by(id: urn.entity_id)
  end

  def self.generate_global_id(entity_type, entity_id)
    scope = IdHasher.make_scope(entity_type)
    hashed_id = IdHasher.new.encode(type: scope, id: entity_id)

    URN::Mazepay.new_hashed_id(scope, hashed_id).to_urn
  end

  # Given a global ID (URN), decode the ID and create a new URN with the clear ID.
  def self.parse_global_id(id)
    urn = ::URN.parse(id)

    # For now, always reject un-hashed IDs. This may become an environment or schema setting.
    # May be desirable to return this as an error or just `nil`?
    clear_ids = IdHasher.new.decode(scope: urn.entity_type, hashed_id: urn.hashed_id)
    raise GraphQL::ExecutionError, "Invalid hash" if clear_ids.none?

    clear_id = clear_ids.fetch(0)

    URN::Mazepay.new_clear_id(urn.entity_type, clear_id)
  rescue URN::ParseError => ex
    raise GraphQL::ExecutionError, ex.message
  end

  private

  def id_hasher()
    IdHasher.new
  end
end

