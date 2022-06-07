module Mutations
  class DeleteStudent < BaseMutation
    argument :id, ID, required: true

    type Types::Student

    def resolve(id:)
      student = Student.find(id)
      student.destroy!
    end
  end
end
