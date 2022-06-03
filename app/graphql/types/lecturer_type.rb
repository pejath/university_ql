# frozen_string_literal: true

module Types
  class LecturerType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :academic_degree, Integer, null: false
    field :department, DepartmentType, null: false

    # has_many
    field :marks, [MarkType], null: false
    field :groups, [GroupType], null: false
    field :lectures, [LectureType], null: false
    field :subjects, [SubjectType], null: false
    field :lecturers_subjects, [LecturersSubjectType], null: false

    # has_one
    field :curatorial_group, GroupType, null: true
  end
end
