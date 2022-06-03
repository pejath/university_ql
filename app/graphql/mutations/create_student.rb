module Mutations
  class CreateStudent < BaseMutation
    argument :name, String, required: true
    argument :group_id, ID, required: true

    type Types::StudentType

    def resolve(name:, group_id:)
      Student.create(
        name: name,
        group_id: group_id
      )
    end
  end
end
