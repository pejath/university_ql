# frozen_string_literal: true

module Types
  class Subject < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    # has_many
    field :marks, [Mark], null: false
    field :groups, [Group], null: false
    field :students, [Student], null: false
    field :lectures, [Lecturer], null: false
    field :lecturers, [Lecturer], null: false
    field :lecturers_subjects, [LecturersSubjectType], null: false

  end
end
