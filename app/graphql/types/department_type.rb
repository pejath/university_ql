# frozen_string_literal: true

module Types
  class DepartmentType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :department_type, Integer, null: false
    field :formation_date, GraphQL::Types::ISO8601Date, null: false

    # belongs_to
    field :faculty, FacultyType, null: false

    # has_many
    field :groups, [GroupType], null: false
    field :lecturers, [LecturerType], null: false
  end
end
