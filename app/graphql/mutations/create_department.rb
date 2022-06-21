module Mutations
  class CreateDepartment < Mutations::BaseMutation
    argument :faculty_id, Types::GlobalId, required: true, loads: Types::Faculty

    argument :name, String, required: true
    argument :department_type, Types::Department::DepartmentTypes, required: true
    argument :formation_date, GraphQL::Types::ISO8601Date, required: true

    type Types::Department

    def resolve(faculty:, name:, department_type:, formation_date:)
      Department.create(
        faculty: faculty,
        name: name,
        department_type: department_type,
        formation_date: formation_date
      )
    end
  end
end
