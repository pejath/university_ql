module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    # faculty
    field :faculties, [Faculty], null: true do
      argument :sort, [Sorting::Base::Input], required: false
      argument :filter, [Filtering::Base::Input], required: false
    end
    def faculties(sort: [], filter: [])
      scope = ::Faculty.all
      scope = Filtering::Base.filter_with(scope, filter)
      Sorting::Base.sort_with(scope, sort)
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
    field :lectures, [Lecture], null: false do
      argument :sort, [Sorting::Base::Input], required: false
      argument :filter, [Filtering::Base::Input], required: false
    end
    def lectures(sort: [], filter: [])
      scope = ::Lecture.all
      scope = Filtering::Base.filter_with(scope, filter)
      Sorting::Base.sort_with(scope, sort)
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
