module Mutations
  class CreateSubject < BaseMutation
    argument :name, String, required: true

    type Types::Subject

    def resolve(name:)
      Subject.create(
        name: name
      )
    end
  end
end
