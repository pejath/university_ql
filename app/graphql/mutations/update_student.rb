module Mutations
  class UpdateStudent < BaseMutation
    argument :group_id, Types::GlobalId, required: true, loads: Types::Group
    argument :student_id, Types::GlobalId, required: true, loads: Types::Student

    argument :name, String, required: true

    type Types::Student

    def resolve(group:, name:, student:)
      student.update(
        name: name,
        group: group
      )
      student.reload
    end
  end
end
