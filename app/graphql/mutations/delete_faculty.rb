module Mutations
  class DeleteFaculty < Mutations::BaseMutation
    argument :faculty_id, Types::GlobalId, required: true, loads: Types::Faculty

    type Types::Faculty

    def resolve(faculty:)
      faculty.destroy!
    end
  end
end
