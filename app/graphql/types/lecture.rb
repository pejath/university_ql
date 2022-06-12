# frozen_string_literal: true

module Types
  class Weekday < Types::BaseEnum
    value 'Monday', value: 'Monday'
    value 'Tuesday', value: 'Tuesday'
    value 'Wednesday', value: 'Wednesday'
    value 'Thursday', value: 'Thursday'
    value 'Friday', value: 'Friday'
    value 'Saturday', value: 'Saturday'
  end

  class Lecture < Types::BaseObject
    implements Interfaces::Timestamps

    field :id, ID, null: false
    field :corpus, Integer, null: false
    field :weekday, Weekday, null: false
    field :auditorium, Integer, null: false

    # belongs_to
    field :group, Group, null: false
    def group
      defer_batch_load(::Group, object.group_id)
    end

    field :lecturer, Lecturer, null: false
    def lecturer
      defer_batch_load(::Lecturer, object.lecturer_id)
    end

    field :subject, Subject, null: false
    def subject
      defer_batch_load(::Subject, object.subject_id)
    end

    field :lecture_time, LectureTime, null: false
    def lecture_time
      defer_batch_load(::LectureTime, object.lecture_time_id)
    end

  end
end
