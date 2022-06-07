# frozen_string_literal: true

module Types
  class FormOfEducation < Types::BaseEnum
    value 'Evening', value: 'evening'
    value 'Correspondence', value: 'correspondence'
    value 'Full_time', value: 'full_time'
  end

  class Group < Types::BaseObject
    field :id, ID, null: false
    field :course, Integer, null: false
    field :specialization_code, Integer, null: false
    field :form_of_education, FormOfEducation, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    # belongs_to
    field :department, Department, null: false
    field :curator, Lecturer, null: false

    # has_many
    field :lectures, [Lecture], null: false
    field :subjects, [Subject], null: false
    field :lecturers, [Lecturer], null: false
  end
end
