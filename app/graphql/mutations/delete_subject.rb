module Mutations
  class DeleteSubject < BaseMutation
    argument :subject_id, Types::GlobalId, required: true, loads: Types::Subject

    type Types::Subject

    def resolve(subject:)
      subject.destroy!
    end
  end
end
