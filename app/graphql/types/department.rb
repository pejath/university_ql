# frozen_string_literal: true

module Types
  class DepartmentTypes < Types::BaseEnum
    value 'Interfacult', value: 'Interfacult'
    value 'Basic', value: 'Basic'
    value 'Military', value: 'Military'
  end

  class Department < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :department_type, DepartmentTypes, null: false
    field :formation_date, GraphQL::Types::ISO8601Date, null: false

    # belongs_to
    field :faculty, Faculty, null: false

    # has_many
    field :groups, [Group], null: false
    field :lecturers, [Lecturer], null: false
  end
end
