module GraphQL
  module Methods
    def execute_query(string, variables: {})
      QlSchema.execute(string, variables: variables)
    end

    def make_global_id(object, query_ctx: nil)
      QlSchema.id_from_object(object, nil, query_ctx)
    end

    def parse_global_id(urn)
      QlSchema.parse_global_id(urn)
    end
  end
end

RSpec.configure do |c|
  c.include(GraphQL::Methods)
end
