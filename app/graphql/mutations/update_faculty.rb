module Mutations
  class UpdateFaculty < Mutations::BaseMutation
    argument :id, ID, required: true
    argument :name, String, required: false
    argument :formation_date, GraphQL::Types::ISO8601Date, required: false

    type Types::FacultyType

    def resolve(id:, name:, formation_date:)
      faculty = Faculty.find(id)
      faculty.update(
        name: name,
        formation_date: formation_date
      )
      faculty.reload
    end
  end
end
