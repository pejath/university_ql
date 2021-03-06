module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    # faculty
    field :faculties, [Faculty], null: false
    def faculties
      ::Faculty.all
    end

    # department
    field :departments, [Department], null: false
    def departments
      ::Department.all
    end

    # lecturer
    field :lecturers, [Lecturer], null: false
    def lecturers
      ::Lecturer.all
    end

    # lecture
    field :lectures, [Lecture], null: false
    def lectures
      ::Lecture.all
    end

    # student
    field :students, [Student], null: false
    def students
      ::Student.all
    end

    # subject
    field :subjects, [Subject], null: false
    def subjects
      ::Subject.all
    end

    # group
    field :groups, [Group], null: false
    def groups
      ::Group.order(:department_id)
    end

    #lecture_time
    field :lecture_time, [LectureTime], null: false
    def lecture_time
      ::LectureTime.all
    end

  end
end
