module Mutations
  class DeleteRecord < BaseMutation
    argument :record_id, Types::GlobalId

    type Types::BaseObject

    def resolve(record_id:)
      record = QlSchema.object_from_id(record_id)
      record.destroy
    end
  end
end

