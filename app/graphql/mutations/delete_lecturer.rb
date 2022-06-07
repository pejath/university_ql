module Mutations
  class DeleteLecturer < BaseMutation
    argument :id, ID, required: true

    type Types::Lecturer

    def resolve(id:)
      lecturer = Lecturer.find(id)
      lecturer.destroy!
    end
  end
end
