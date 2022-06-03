# frozen_string_literal: true

module Types
  class MarkType < Types::BaseObject
    field :id, ID, null: false
    field :mark, Integer, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    # belongs_to
    field :student, StudentType, null: false
    field :subject, SubjectType, null: false
    field :lecturer, LecturerType, null: false
  end
end
