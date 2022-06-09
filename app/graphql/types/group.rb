# frozen_string_literal: true

module Types
  class FormOfEducation < Types::BaseEnum
    value 'Evening', value: 'evening'
    value 'Correspondence', value: 'correspondence'
    value 'Full_time', value: 'full_time'
  end

  class Group < Types::BaseRecordObject
    field :course, Integer, null: false
    field :specialization_code, Integer, null: false
    field :form_of_education, FormOfEducation, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    # belongs_to
    field :department, Department, null: false
    def department
      defer_batch_load(::Department, object.department_id)
    end

    field :curator, Lecturer, null: true
    def curator
      defer_batch_load(::Lecturer, object.curator_id)
    end

    # has_many
    field :lectures, [Lecture], null: true
    def lectures
      defer_load_has_many(::Lecture, :group, object)
    end

    field :subjects, [Subject], null: true
    def subjects
      defer_load_has_many(::Subject, :group, object)
    end

    field :lecturers, [Lecturer], null: true
    def lecturers
      defer_load_has_many(::Lecturer, :group, object)
    end
  end
end
