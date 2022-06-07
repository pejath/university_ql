module Mutations
  class UpdateLecturer < BaseMutation
    argument :id, ID, required: true
    argument :department_id, ID, required: true
    argument :name, String, required: true
    argument :academic_degree, Integer, required: true

    type Types::Lecturer

    def resolve(id:, department_id:, name:, academic_degree:)
      lecturer = Lecturer.find(id)
      lecturer.update(
        name: name,
        department_id: department_id,
        academic_degree: academic_degree
      )
      lecturer.reload
    end
  end
end
