module Mutations
  class CreateGroup < BaseMutation
    argument :curator_id, Types::GlobalId, required: true, loads: Types::Lecturer
    argument :department_id, Types::GlobalId, required: true, loads: Types::Department

    argument :course, Integer, required: true
    argument :specialization_code, Integer, required: true
    argument :form_of_education, Types::Group::FormOfEducation, required: true

    type Types::Group

    def resolve(curator:, department:, course:, form_of_education:, specialization_code:)
      Group.create(
        curator: curator,
        department: department,
        course: course,
        form_of_education: form_of_education,
        specialization_code: specialization_code
      )
    end
  end
end
