module Mutations
  class UpdateSubject < BaseMutation
    argument :subject_id, Types::GlobalId, required: true, loads: Types::Subject

    argument :name, String, required: true

    type Types::Subject

    def resolve(subject:, name:)
      subject.update(
        name: name
      )
      subject.reload
    end
  end
end
