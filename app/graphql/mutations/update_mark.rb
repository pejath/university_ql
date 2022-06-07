module Mutations
  class UpdateMark < BaseMutation
    argument :id, ID, required: true
    argument :mark, Integer, required: true
    argument :student_id, ID, required: true
    argument :subject_id, ID, required: true
    argument :lecturer_id, ID, required: true

    type Types::Mark

    def resolve(student_id:, subject_id:, lecturer_id:, mark:)
      mark.update(
        student_id: student_id,
        subject_id: subject_id,
        lecturer_id: lecturer_id,
        mark: mark
      )
      mark.reload
    end
  end
end
