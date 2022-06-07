module Mutations
  class DeleteGroup < BaseMutation
    argument :id, ID, required: true

    type Types::Group

    def resolve(id:)
      group = Group.find(id)
      group.destroy!
    end
  end
end
