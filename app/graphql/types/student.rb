# frozen_string_literal: true

module Types
  class Student < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    # belongs_to
    field :group, Group, null: false

    # has_many
    field :marks, [Mark], null: false
    field :subjects, [Subject], null: false

  end
end
