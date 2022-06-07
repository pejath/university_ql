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
      Faculty.all
    end

    field :faculty, Faculty, null: false do
      argument :id, ID, required: true
    end

    def faculty(id:)
      Faculty.find(id)
    end

    # department
    field :departments, [Department], null: false
    def departments
      Department.all
    end

    field :department, Department, null: false do
      argument :id, ID, required: true
    end
    def department(id:)
      Department.find(id)
    end

    # lecturer
    field :lecturers, [Lecturer], null: false
    def lecturers
      Lecturer.all
    end

    field :lecturer, Lecturer, null: false do
      argument :id, ID, required: true
    end
    def lecturer(id:)
      Lecturer.find(id)
    end

    # lecture
    field :lectures, [Lecture], null: false
    def lectures
      Lecture.preload(:lecture_time, :lecturer, :group, :subject)
    end

    field :lecture, Lecture, null: false do
      argument :id, ID, required: true
    end
    def lecture(id:)
      Lecture.preload(:lecture_time, :lecturer, :group, :subject).find(id)
    end

    # student
    field :students, [Student], null: false
    def students
      Student.preload(:marks, :group)
    end

    field :student, Student, null: false do
      argument :id, ID, required: true
    end
    def student(id:)
      Student.preload(:marks, :group).find(id)
    end

    # subject
    field :subjects, [Subject], null: false
    def subjects
      Subject.preload(:lecturers)
    end

    field :subject, Subject, null: false do
      argument :id, ID, required: true
    end
    def subject(id:)
      Subject.preload(:lecturers).find(id)
    end

    # group
    field :groups, [Group], null: false
    def groups
      Group.preload(:department, :curator).order(:department_id)
    end

    field :group, Group, null: false do
      argument :id, ID, required: true
    end
    def group(id:)
      Group.preload(:department, :curator).order(:department_id).find(id)
    end


    field :lecture_time, [LectureTime], null: false
    def lecture_time
      LectureTime.all
    end

  end
end
