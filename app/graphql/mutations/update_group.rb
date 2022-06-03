module Mutations
  class UpdateGroup < BaseMutation
    argument :id, ID, required: true
    argument :curator_id, ID, required: true
    argument :department_id, ID, required: true
    argument :course, Integer, required: true
    argument :form_of_education, Integer, required: true
    argument :specialization_code, Integer, required: true

    type Types::GroupType

    def resolve(id:, curator_id:, department_id:, course:, form_of_education:, specialization_code:)
      group = Group.find(id)
      curator = Lecturer.find(curator_id)
      group.update(
        curator: curator,
        department_id: department_id,
        course: course,
        form_of_education: form_of_education,
        specialization_code: specialization_code
      )
      group.reload
    end
  end
end
