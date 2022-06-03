module Mutations
  class DeleteGroup < BaseMutation
    argument :id, ID, required: true

    type Types::GroupType

    def resolve(id:)
      group = Group.find(id)
      group.destroy!
    end
  end
end
