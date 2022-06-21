module Mutations
  class DeleteDepartment < BaseMutation
    argument :department_id, Types::GlobalId, required: true, loads: Types::Department

    type Types::Department

    def resolve(department:)
      department.destroy!
    end
  end
end
