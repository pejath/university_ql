module Mutations
  class CreateDepartment < Mutations::BaseMutation
    argument :name, String, required: true
    argument :faculty_id, ID, required: true
    argument :department_type, Types::DepartmentTypes, required: true
    argument :formation_date, GraphQL::Types::ISO8601Date, required: true

    type Types::Department

    def resolve(faculty_id:, name:, department_type:, formation_date:)
      Department.create(
        faculty_id: faculty_id,
        name: name,
        department_type: department_type,
        formation_date: formation_date
      )
    end
  end
end
