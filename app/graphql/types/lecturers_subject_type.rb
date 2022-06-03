# frozen_string_literal: true

module Types
  class LecturersSubjectType < Types::BaseObject
    field :id, ID, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    # belongs_to
    field :subject, SubjectType
    field :lecturer, LecturerType
  end
end
