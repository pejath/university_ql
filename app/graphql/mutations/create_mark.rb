module Mutations
  class CreateMark < BaseMutation
    argument :mark, Integer, required: true
    argument :student_id, ID, required: true
    argument :subject_id, ID, required: true
    argument :lecturer_id, ID, required: true


    type Types::MarkType

    def resolve(student_id:, subject_id:, lecturer_id:, mark:)
      Mark.create(
        student_id: student_id,
        subject_id: subject_id,
        lecturer_id: lecturer_id,
        mark: mark
      )
    end
  end
end
