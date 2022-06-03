module Mutations
  class UpdateDepartment < BaseMutation
    argument :id, ID, required: true
    argument :name, String, required: true
    argument :faculty_id, ID, required: true
    argument :department_type, Integer, required: true
    argument :formation_date, GraphQL::Types::ISO8601Date, required: true

    type Types::DepartmentType

    def resolve(id:, name:, faculty_id:, department_type:, formation_date:)
      department = Department.find(id)
      department.update(
        name: name,
        faculty_id: faculty_id,
        department_type: department_type,
        formation_date: formation_date
      )
      department.reload
    end
  end
end
