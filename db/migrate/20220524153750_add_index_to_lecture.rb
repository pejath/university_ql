class AddIndexToLecture < ActiveRecord::Migration[6.1]
  def change
    add_index :lectures, [:corpus, :auditorium, :lecture_time_id, :group_id, :lecturer_id, :weekday], unique: true, name: 'lecture_index'
  end
end
