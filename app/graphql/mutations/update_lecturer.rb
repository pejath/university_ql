module Mutations
  class UpdateLecturer < BaseMutation
    argument :lecturer_id, Types::GlobalId, required: true, loads: Types::Lecturer
    argument :department_id, Types::GlobalId, required: true, loads: Types::Department

    argument :name, String, required: true
    argument :academic_degree, Integer, required: true

    type Types::Lecturer

    def resolve(lecturer:, department:, name:, academic_degree:)
      lecturer.update(
        name: name,
        department: department,
        academic_degree: academic_degree
      )
      lecturer.reload
    end
  end
end
