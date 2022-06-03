module Mutations
  class CreateSubject < BaseMutation
    argument :name, String, required: true

    type Types::SubjectType

    def resolve(name:)
      Subject.create(
        name: name
      )
    end
  end
end
