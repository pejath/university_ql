# frozen_string_literal: true

module Types
  class Subject < Types::BaseObject
    field :name, String, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    # has_many
    field :marks, [Mark], null: true
    def marks
      defer_load_has_many(::Mark, :subject, object)
    end

    field :groups, [Group], null: true
    def groups
      defer_load_has_many(::Group, :subject, object)
    end

    field :students, [Student], null: true
    def students
      defer_load_has_many(::Student, :subject, object)
    end

    field :lectures, [Lecturer], null: true
    def lectures
      defer_load_has_many(::Lecturer, :subject, object)
    end

    field :lecturers, [Lecturer], null: true
    def lecturers
      defer_load_has_many(::Lecturer, :subject, object)
    end

    field :lecturers_subjects, [LecturersSubjectType], null: true
    def lecturers_subjects
      defer_load_has_many(::LecturersSubjectType, :subject, object)
    end
  end
end
