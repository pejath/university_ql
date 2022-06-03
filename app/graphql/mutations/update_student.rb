module Mutations
  class UpdateStudent < BaseMutation
    argument :id, ID, required: true
    argument :name, String, required: true
    argument :group_id, ID, required: true

    type Types::StudentType

    def resolve(id:, name:, group_id:)
      student = Student.find(id)
      student.create(
        name: name,
        group_id: group_id
      )
      student.reload
    end
  end
end
