# frozen_string_literal: true

module Types
  class StudentType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    # belongs_to
    field :group, GroupType, null: false

    # has_many
    field :marks, [MarkType], null: false
    field :subjects, [SubjectType], null: false

  end
end
