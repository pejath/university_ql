module Mutations
  class DeleteGroup < BaseMutation
    argument :group_id, Types::GlobalId, required: true, loads: Types::Group

    type Types::Group

    def resolve(group:)
      group.destroy!
    end
  end
end
