module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    # faculty
    field :faculties, [Faculty], null: true do
      argument :sort, [Sorting::Base::SortInput], required: false
      argument :filter, [Filtering::Base::FilterInput], required: false
    end
    def faculties(sort: [], filter: [])
      scope = ::Faculty.all
      scope = Filtering::Base.filter_with(scope, filter)
      Sorting::Base.sort_with(scope, sort)
    end

    # department
    field :departments, [Department], null: false do
      argument :sort, [Sorting::Base::SortInput], required: false
      argument :filter, [Filtering::Base::FilterInput], required: false
    end
    def departments(sort: [], filter: [])
      scope = ::Department.all
      scope = Filtering::Base.filter_with(scope, filter)
      Sorting::Base.sort_with(scope, sort)
    end

    # lecturer
    field :lecturers, [Lecturer], null: false do
      argument :sort, [Sorting::Base::SortInput], required: false
      argument :filter, [Filtering::Base::FilterInput], required: false
    end
    def lecturers(sort: [], filter: [])
      scope = ::Lecturer.all
      scope = Filtering::Base.filter_with(scope, filter)
      Sorting::Base.sort_with(scope, sort)
    end

    # lecture
    field :lectures, [Lecture], null: false do
      argument :sort, [Sorting::Base::SortInput], required: false
      argument :filter, [Filtering::Base::FilterInput], required: false
    end
    def lectures(sort: [], filter: [])
      scope = ::Lecture.all
      scope = Filtering::Base.filter_with(scope, filter)
      Sorting::Base.sort_with(scope, sort)
    end

    # student
    field :students, [Student], null: false do
      argument :sort, [Sorting::Base::SortInput], required: false
      argument :filter, [Filtering::Base::FilterInput], required: false
    end
    def students(sort: [], filter: [])
      scope = ::Student.all
      scope = Filtering::Base.filter_with(scope, filter)
      Sorting::Base.sort_with(scope, sort)
    end

    # subject
    field :subjects, [Subject], null: false do
      argument :sort, [Sorting::Base::SortInput], required: false
      argument :filter, [Filtering::Base::FilterInput], required: false
    end
    def subjects(sort: [], filter: [])
      scope = ::Subject.all
      scope = Filtering::Base.filter_with(scope, filter)
      Sorting::Base.sort_with(scope, sort)
    end

    # group
    field :groups, [Group], null: false do
      argument :sort, [Sorting::Base::SortInput], required: false
      argument :filter, [Filtering::Base::FilterInput], required: false
    end
    def groups(sort: [], filter: [])
      scope = ::Group.all
      scope = Filtering::Base.filter_with(scope, filter)
      Sorting::Base.sort_with(scope, sort)
    end

    #lecture_time
    field :lecture_time, [LectureTime], null: false
    def lecture_time
      ::LectureTime.all
    end

  end
end
