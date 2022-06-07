# frozen_string_literal: true

module Types
  class Lecture < Types::BaseObject
    field :id, ID, null: false
    field :corpus, Integer, null: false
    field :weekday, Integer, null: false
    field :auditorium, Integer, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    # belongs_to
    field :group, Group
    field :lecturer, Lecturer
    field :subject, Subject
    field :lecture_time, LectureTime
  end
end
