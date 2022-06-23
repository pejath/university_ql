module Mutations
  class DeleteLecture < BaseMutation
    argument :lecture_id, Types::GlobalId, required: true, loads: Types::Lecture

    type Types::Lecture

    def resolve(lecture:)
      lecture.destroy!
    end
  end
end
