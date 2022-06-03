module Mutations
  class DeleteDepartment < BaseMutation
    argument :id, ID, required: true

    type Types::DepartmentType

    def resolve(id:)
      department = Department.find(id)
      department.destroy!
      { department: department }
    end
  end
end
