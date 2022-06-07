# frozen_string_literal: true

module Types
  class LectureTime < Types::BaseObject
    field :id, ID, null: false
    field :beginning, String, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    # has_many
    field :lectures, [Lecture], null: false
  end
end
