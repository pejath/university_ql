module Mutations
  class DeleteFaculty < Mutations::BaseMutation
    argument :id, ID, required: true

    type Types::FacultyType

    def resolve(id:)
      faculty = Faculty.find(id)
      faculty.destroy!
    end
  end
end
