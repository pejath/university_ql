module Mutations
  class DeleteDepartment < BaseMutation
    argument :id, ID, required: true

    type Types::Department

    def resolve(id:)
      department = Department.find(id)
      department.destroy!
    end
  end
end
