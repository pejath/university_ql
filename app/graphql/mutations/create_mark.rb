module Mutations
  class CreateMark < BaseMutation
    argument :student_id, Types::GlobalId, required: true, loads: Types::Student
    argument :subject_id, Types::GlobalId, required: true, loads: Types::Subject
    argument :lecturer_id, Types::GlobalId, required: true, loads: Types::Lecturer

    argument :value, Integer, required: true

    type Types::Mark

    def resolve(student:, subject:, lecturer:, value:)
      Mark.create(
        student: student,
        subject: subject,
        lecturer: lecturer,
        mark: value
      )
    end
  end
end
