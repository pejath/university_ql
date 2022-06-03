module Mutations
  class CreateLecturer < BaseMutation
    argument :department_id, ID, required: true
    argument :name, String, required: true
    argument :academic_degree, Integer, required: true

    type Types::LecturerType

    def resolve(department_id:, name:, academic_degree:)
      Lecturer.create(
        name: name,
        department_id: department_id,
        academic_degree: academic_degree
      )
    end
  end
end
