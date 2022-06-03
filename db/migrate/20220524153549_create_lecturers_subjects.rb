class CreateLecturersSubjects < ActiveRecord::Migration[6.1]
  def change
    create_table :lecturers_subjects do |t|
      t.belongs_to :lecturer
      t.belongs_to :subject
      t.timestamps
    end
    add_index :lecturers_subjects, [:lecturer_id, :subject_id], unique: true
  end
end
