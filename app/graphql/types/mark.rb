# frozen_string_literal: true

module Types
  class Mark < Types::BaseObject
    implements Interfaces::Timestamps

    field :id, ID, null: false
    field :mark, Integer, null: false

    # belongs_to
    field :student, Student, null: true
    def student
      defer_batch_load(::Student, object.student_id)
    end

    field :subject, Subject, null: true
    def subject
      defer_batch_load(::Subject, object.subject_id)
    end

    field :lecturer, Lecturer, null: true
    def lecturer
      defer_batch_load(::Lecturer, object.lecturer_id)
    end
  end
end
