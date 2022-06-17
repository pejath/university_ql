module Mutations
  class CreateGroup < BaseMutation
    argument :curator_id, ID, required: true
    argument :department_id, ID, required: true
    argument :course, Integer, required: true
    argument :specialization_code, Integer, required: true
    argument :form_of_education, Types::Group::FormOfEducation, required: true

    type Types::Group

    def resolve(curator_id:, department_id:, course:, form_of_education:, specialization_code:)
      curator = Lecturer.find(curator_id)
      Group.create(
        curator: curator,
        department_id: department_id,
        course: course,
        form_of_education: form_of_education,
        specialization_code: specialization_code
      )
    end
  end
end
