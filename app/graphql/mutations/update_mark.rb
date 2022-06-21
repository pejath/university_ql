module Mutations
  class UpdateMark < BaseMutation
    argument :mark_id, Types::GlobalId, required: true, loads: Types::Mark
    argument :student_id, Types::GlobalId, required: true, loads: Types::Student
    argument :subject_id, Types::GlobalId, required: true, loads: Types::Subject
    argument :lecturer_id, Types::GlobalId, required: true, loads: Types::Lecturer

    argument :value, Integer, required: true

    type Types::Mark

    def resolve(student:, subject:, lecturer:, mark:, value:)
      puts mark
      mark.update(
        student: student,
        subject: subject,
        lecturer: lecturer,
        mark: value
      )
      mark.reload
    end
  end
end
