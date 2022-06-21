# frozen_string_literal: true

module Types
  class LecturersSubjectType < Types::BaseObject
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    # belongs_to
    field :subject, Subject, null: false
    def subject
      defer_batch_load(::Subject, object.subject_id)
    end

    field :lecturer, Lecturer, null: false
    def department
      defer_batch_load(::Lecturer, object.lecturer_id)
    end
  end
end
