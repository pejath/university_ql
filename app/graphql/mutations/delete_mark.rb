module Mutations
  class DeleteMark < BaseMutation
    argument :mark_id, Types::GlobalId, required: true, loads: Types::Mark

    type Types::Mark

    def resolve(mark:)
      mark.destroy!
    end
  end
end
