module Mutations
  class DeleteMark < BaseMutation
    argument :id, ID, required: true

    type Types::MarkType

    def resolve(id:)
      mark = Mark.find(id)
      mark.destroy!
    end
  end
end
