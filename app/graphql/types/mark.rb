# frozen_string_literal: true

module Types
  class Mark < Types::BaseObject
    field :id, ID, null: false
    field :mark, Integer, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    # belongs_to
    field :student, Student, null: false
    field :subject, Subject, null: false
    field :lecturer, Lecturer, null: false
  end
end
