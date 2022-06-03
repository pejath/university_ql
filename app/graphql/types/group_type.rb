# frozen_string_literal: true

module Types
  class GroupType < Types::BaseObject
    field :id, ID, null: false
    field :course, Integer, null: false
    field :form_of_education, Integer, null: false
    field :specialization_code, Integer, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    # belongs_to
    field :department, DepartmentType, null: false
    field :curator, LecturerType, null: false

    # has_many
    field :lectures, [LectureType], null: false
    field :subjects, [SubjectType], null: false
    field :lecturers, [LecturerType], null: false
  end
end
