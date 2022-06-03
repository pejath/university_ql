# frozen_string_literal: true

module Types
  class LectureType < Types::BaseObject
    field :id, ID, null: false
    field :corpus, Integer, null: false
    field :weekday, Integer, null: false
    field :auditorium, Integer, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    # belongs_to
    field :group, GroupType
    field :lecturer, LecturerType
    field :subject_id, SubjectType
    field :lecture_time, LectureTimeType
  end
end
