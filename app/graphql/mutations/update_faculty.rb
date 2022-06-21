module Mutations
  class UpdateFaculty < Mutations::BaseMutation
    argument :faculty_id, Types::GlobalId, required: true, loads: Types::Faculty
    argument :name, String, required: false
    argument :formation_date, GraphQL::Types::ISO8601Date, required: false

    type Types::Faculty

    def resolve(faculty:, name:, formation_date:)
      faculty.update(
        name: name,
        formation_date: formation_date
      )
      faculty.reload
    end
  end
end
