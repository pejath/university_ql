module Mutations
  class DeleteLecturer < BaseMutation
    argument :lecturer_id, Types::GlobalId, required: true, loads: Types::Lecturer

    type Types::Lecturer

    def resolve(lecturer:)
      # lecturer = Lecturer.find(id)
      lecturer.destroy!
    end
  end
end
