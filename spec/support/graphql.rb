module GraphQL
  module Methods
    def execute_query(string, variables: {})
      QlSchema.execute(string, variables: variables)
    end
  end
end

RSpec.configure do |c|
  c.include(GraphQL::Methods)
end
