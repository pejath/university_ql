# frozen_string_literal: true

module Types
  class FacultyType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :formation_date, GraphQL::Types::ISO8601Date, null: false

    # has_many
    field :departments, [DepartmentType], null: false
  end
end
