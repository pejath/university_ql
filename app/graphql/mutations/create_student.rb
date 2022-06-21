module Mutations
  class CreateStudent < BaseMutation
    argument :group_id, Types::GlobalId, required: true, loads: Types::Group

    argument :name, String, required: true

    type Types::Student

    def resolve(name:, group:)
      Student.create(
        name: name,
        group: group
      )
    end
  end
end
