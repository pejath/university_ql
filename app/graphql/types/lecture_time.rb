# frozen_string_literal: true

module Types
  class LectureTime < Types::BaseRecordObject
    field :beginning, String, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    # has_many
    field :lectures, [Lecture], null: true
    def lectures
      defer_load_has_many(::Lecture, :lecture_time, object)
    end
  end
end
