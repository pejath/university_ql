module Mutations
  class UpdateLecture < BaseMutation
    argument :lecture_id, Types::GlobalId, required: true, loads: Types::Lecture
    argument :group_id, Types::GlobalId, required: true, loads: Types::Group
    argument :subject_id, Types::GlobalId, required: true, loads: Types::Subject
    argument :lecturer_id, Types::GlobalId, required: true, loads: Types::Lecturer
    argument :lecture_time_id, Types::GlobalId, required: true, loads: Types::LectureTime

    argument :corpus, Integer, required: true
    argument :weekday, Types::Weekday, required: true
    argument :auditorium, Integer, required: true

    type Types::Lecture

    def resolve(lecture:, group:, subject:, lecturer:, lecture_time:, corpus:, weekday:, auditorium:)
      lecture.update(
        group: group,
        subject: subject,
        lecturer: lecturer,
        lecture_time: lecture_time,
        corpus: corpus,
        weekday: weekday,
        auditorium: auditorium
      )
      lecture.reload
    end
  end
end
