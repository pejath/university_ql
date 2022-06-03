class CreateLectures < ActiveRecord::Migration[6.1]
  def change
    create_table :lectures do |t|
      t.belongs_to :lecture_time
      t.belongs_to :group
      t.belongs_to :lecturer
      t.belongs_to :subject
      t.integer :weekday, null: false
      t.integer :corpus, null: false
      t.integer :auditorium, null: false


      t.timestamps
    end
  end
end
