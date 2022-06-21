module Mutations
  class CreateLecturer < BaseMutation
    argument :department_id, Types::GlobalId, required: true, loads: Types::Department

    argument :name, String, required: true
    argument :academic_degree, Integer, required: true

    type Types::Lecturer

    def resolve(department:, name:, academic_degree:)
      Lecturer.create(
        name: name,
        department: department,
        academic_degree: academic_degree
      )
    end
  end
end
