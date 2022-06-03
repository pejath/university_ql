module Types
  class MutationType < Types::BaseObject
    # faculty mutations
    field :create_faculty, mutation: Mutations::CreateFaculty
    field :update_faculty, mutation: Mutations::UpdateFaculty
    field :delete_faculty, mutation: Mutations::DeleteFaculty

    # group mutations
    field :create_group, mutation: Mutations::CreateGroup
    field :update_group, mutation: Mutations::UpdateGroup
    field :delete_group, mutation: Mutations::DeleteGroup

    # department mutations
    field :create_department, mutation: Mutations::CreateDepartment
    field :update_department, mutation: Mutations::UpdateDepartment
    field :delete_department, mutation: Mutations::DeleteDepartment

    # lecture mutations
    field :create_lecture, mutation: Mutations::CreateLecture
    field :update_lecture, mutation: Mutations::UpdateLecture
    field :delete_lecture, mutation: Mutations::DeleteLecture

    # lecturer mutations
    field :create_lecturer, mutation: Mutations::CreateLecturer
    field :update_lecturer, mutation: Mutations::UpdateLecturer
    field :delete_lecturer, mutation: Mutations::DeleteLecturer

    # mark mutations
    field :create_mark, mutation: Mutations::CreateMark
    field :update_mark, mutation: Mutations::UpdateMark
    field :delete_mark, mutation: Mutations::DeleteMark

    # student mutations
    field :create_student, mutation: Mutations::CreateStudent
    field :update_student, mutation: Mutations::UpdateStudent
    field :delete_student, mutation: Mutations::DeleteStudent

    # subject mutations
    field :create_subject, mutation: Mutations::CreateSubject
    field :update_subject, mutation: Mutations::UpdateSubject
    field :delete_subject, mutation: Mutations::DeleteSubject
  end
end
