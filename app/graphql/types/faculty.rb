# frozen_string_literal: true

module Types
  class Faculty < Types::BaseRecordObject
    field :name, String, null: false
    field :formation_date, GraphQL::Types::ISO8601Date, null: false

    # has_many
    field :departments, [Department], null: true
    def departments
      defer_load_has_many(::Department, :department, object)
    end
  end
end
