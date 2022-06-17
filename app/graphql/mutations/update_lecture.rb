module Mutations
  class UpdateLecture < BaseMutation
    argument :id, ID, required: true
    argument :group_id, ID, required: true
    argument :subject_id, ID, required: true
    argument :lecturer_id, ID, required: true
    argument :lecture_time_id, ID, required: true

    argument :corpus, Integer, required: true
    argument :weekday, Types::Weekday, required: true
    argument :auditorium, Integer, required: true

    type Types::Lecture

    def resolve(id:, group_id:, subject_id:, lecturer_id:, lecture_time_id:, corpus:, weekday:, auditorium:)
      lecture = Lecture.find(id)
      lecture.update(
        group_id: group_id,
        subject_id: subject_id,
        lecturer_id: lecturer_id,
        lecture_time_id: lecture_time_id,
        corpus: corpus,
        weekday: weekday,
        auditorium: auditorium
      )
      lecture.reload
    end
  end
end
