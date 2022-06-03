module Mutations
  class DeleteLecturer < BaseMutation
    argument :id, ID, required: true

    type Types::LecturerType

    def resolve(id:)
      lecturer = Lecturer.find(id)
      lecturer.destroy!
    end
  end
end
