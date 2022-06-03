module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    # faculty
    field :faculties, [FacultyType], null: false
    def faculties
      Faculty.all
    end

    field :faculty, FacultyType, null: false do
      argument :id, ID, required: true
    end

    def faculty(id:)
      Faculty.find(id)
    end

    # department
    field :departments, [DepartmentType], null: false
    def departments
      Department.all
    end

    field :department, DepartmentType, null: false do
      argument :id, ID, required: true
    end
    def department(id:)
      Department.find(id)
    end

    # lecturer
    field :lecturers, [LecturerType], null: false
    def lecturers
      Lecturer.all
    end

    field :lecturer, LecturerType, null: false do
      argument :id, ID, required: true
    end
    def lecturer(id:)
      Lecturer.find(id)
    end

    field :free_curators, [LecturerType], null: false do
      argument :group, ID, required: true
    end
    def free_curators(group:)
      Lecturer.where.missing(:curatorial_group).or(Lecturer.where(curatorial_group: group))
    end

    # student
    field :students, [StudentType], null: false
    def students
      Student.preload(:marks, :group)
    end

    field :student, StudentType, null: false do
      argument :id, ID, required: true
    end
    def student(id:)
      Student.preload(:marks, :group).find(id)
    end

    # subject
    field :subjects, [SubjectType], null: false
    def subjects
      Subject.preload(:lecturers)
    end

    field :student, SubjectType, null: false do
      argument :id, ID, required: true
    end
    def subject(id:)
      Subject.preload(:lecturers).find(id)
    end

    # group
    field :groups, [GroupType], null: false
    def groups
      Group.preload(:department, :curator).order(:department_id)
    end

    field :group, GroupType, null: false do
      argument :id, ID, required: true
    end
    def group(id:)
      Group.preload(:department, :curator).order(:department_id).find(id)
    end


    field :lecture_time, [LectureTimeType], null: false
    def lecture_time
      LectureTime.all
    end

  end
end
