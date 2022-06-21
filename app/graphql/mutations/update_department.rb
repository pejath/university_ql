module Mutations
  class UpdateDepartment < BaseMutation
    argument :faculty_id, Types::GlobalId, required: true, loads: Types::Faculty
    argument :department_id, Types::GlobalId, required: true, loads: Types::Department

    argument :name, String, required: true
    argument :department_type, Types::Department::DepartmentTypes, required: true
    argument :formation_date, GraphQL::Types::ISO8601Date, required: true

    type Types::Department

    def resolve(department:, name:, faculty:, department_type:, formation_date:)
      department.update!(
        name: name,
        faculty: faculty,
        department_type: department_type,
        formation_date: formation_date
      )
      department.reload
    end
  end
end
