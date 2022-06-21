# frozen_string_literal: true

module Types
  class Student < Types::BaseObject
    field :name, String, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    # belongs_to
    field :group, Group, null: false
    def department
      defer_batch_load(::Group, object.group_id)
    end

    # has_many
    field :marks, [Mark], null: false
    def mark
      defer_load_has_many(::Mark, :student, object)
    end

    field :subjects, [Subject], null: false
    def subject
      defer_load_has_many(::Subject, :student, object)
    end
  end
end
