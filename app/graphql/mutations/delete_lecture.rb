module Mutations
  class DeleteLecture < BaseMutation
    argument :id, ID, required: true

    type Types::Lecture

    def resolve(id:)
      lecture = Lecture.find(id)
      lecture.destroy!
    end
  end
end
