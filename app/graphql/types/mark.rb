# frozen_string_literal: true

module Types
  class Mark < Types::BaseObject
    implements Interfaces::Timestamps

    field :mark, Integer, null: false

    # belongs_to
    field :student, Student, null: false
    def student
      defer_batch_load(::Student, object.student_id)
    end

    field :subject, Subject, null: false
    def subject
      defer_batch_load(::Subject, object.subject_id)
    end

    field :lecturer, Lecturer, null: false
    def lecturer
      defer_batch_load(::Lecturer, object.lecturer_id)
    end
  end
end
