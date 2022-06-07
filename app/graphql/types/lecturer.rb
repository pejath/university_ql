# frozen_string_literal: true

module Types
  class Lecturer < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :academic_degree, Integer, null: false
    field :department, Department, null: false

    # has_many
    field :marks, [Mark], null: false
    field :groups, [Group], null: false
    field :lectures, [Lecture], null: false
    field :subjects, [Subject], null: false
    field :lecturers_subjects, [LecturersSubjectType], null: false

    # has_one
    field :curatorial_group, Group, null: true
  end
end
