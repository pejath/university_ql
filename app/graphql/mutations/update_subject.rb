module Mutations
  class UpdateSubject < BaseMutation
    argument :id, ID, required: true
    argument :name, String, required: true

    type Types::SubjectType

    def resolve(id:, name:)
      subject = Subject.find(id)
      subject.update(
        name: name
      )
      subject.reload
    end
  end
end
