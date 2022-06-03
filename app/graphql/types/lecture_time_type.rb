# frozen_string_literal: true

module Types
  class LectureTimeType < Types::BaseObject
    field :id, ID, null: false
    field :beginning, String, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    # has_many
    field :lectures, [LectureType], null: false
  end
end
