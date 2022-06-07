module Mutations
  class DeleteMark < BaseMutation
    argument :id, ID, required: true

    type Types::Mark

    def resolve(id:)
      mark = Mark.find(id)
      mark.destroy!
    end
  end
end
