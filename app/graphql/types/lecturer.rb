# frozen_string_literal: true

module Types
  class Lecturer < Types::BaseRecordObject
    field :name, String, null: false
    field :academic_degree, Integer, null: false

    # belongs_to
    field :department, Department, null: false
    def department
      defer_batch_load(::Department, object.department_id)
    end

    # has_many
    field :marks, [Mark], null: true
    def marks
      defer_load_has_many(::Mark, :lecturer, object)
    end

    field :groups, [Group], null: true
    def groups
      defer_load_has_many(::Groups, :lecturer, object)
    end
    field :lectures, [Lecture], null: true
    def lectures
      defer_load_has_many(::Lectures, :lecturer, object)
    end

    field :subjects, [Subject], null: true
    def subjects
      defer_load_has_many(::Subjects, :lecturer, object)
    end

    field :lecturers_subjects, [LecturersSubjectType], null: true
    def lecturers_subjects
      defer_load_has_many(::LecturersSubjectType, :lecturer, object)
    end

    # has_one
    field :curatorial_group, Group, null: true
    def curatorial_group
      defer_load_has_one(::Group, :curator_id, object)
    end

  end
end
