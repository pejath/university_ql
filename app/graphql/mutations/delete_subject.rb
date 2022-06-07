module Mutations
  class DeleteSubject < BaseMutation
    argument :id, ID, required: true

    type Types::Subject

    def resolve(id:)
      subject = Subject.find(id)
      subject.destroy!
    end
  end
end
