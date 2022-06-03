module Mutations
  class CreateFaculty < Mutations::BaseMutation
    argument :name, String, required: true
    argument :formation_date, GraphQL::Types::ISO8601Date, required: true

    type Types::FacultyType

    def resolve(formation_date: nil, name: nil)
      Faculty.create!(
        formation_date: formation_date,
        name: name
      )
    end
  end
end
