module Mutations
  class DeleteSubject < BaseMutation
    argument :id, ID, required: true

    type Types::SubjectType

    def resolve(id:)
      subject = Subject.find(id)
      subject.destroy!
    end
  end
end
