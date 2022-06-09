# frozen_string_literal: true

module Types
  class DepartmentTypes < Types::BaseEnum
    value 'Interfacult', value: 'Interfacult'
    value 'Basic', value: 'Basic'
    value 'Military', value: 'Military'
  end

  class Department < Types::BaseObject

    implements Interfaces::Timestamps

    field :id, ID, null: false
    field :name, String, null: false
    field :department_type, DepartmentTypes, null: false
    field :formation_date, GraphQL::Types::ISO8601Date, null: false

    # belongs_to
    field :faculty, Faculty, null: false
    def faculty
      defer_batch_load(::Faculty, object.faculty_id)
    end

    # has_many
    field :groups, [Group], null: true
    def groups
      defer_load_has_many(::Group, :department, object)
    end

    field :lecturers, [Lecturer], null: true
    def lecturers
      defer_load_has_many(::Lecturer, :department, object)
    end
  end
end
