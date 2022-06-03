# frozen_string_literal: true

module Types
  class SubjectType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    # has_many
    field :marks, [MarkType], null: false
    field :groups, [GroupType], null: false
    field :students, [StudentType], null: false
    field :lectures, [LecturerType], null: false
    field :lecturers, [LecturerType], null: false
    field :lecturers_subjects, [LecturersSubjectType], null: false

  end
end
