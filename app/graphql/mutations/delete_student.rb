module Mutations
  class DeleteStudent < BaseMutation
    argument :student_id, Types::GlobalId, required: true, loads: Types::Student

    type Types::Student

    def resolve(student:)
      student.destroy!
    end
  end
end
