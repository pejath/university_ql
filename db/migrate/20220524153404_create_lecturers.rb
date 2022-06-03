class CreateLecturers < ActiveRecord::Migration[6.1]
  def change
    create_table :lecturers do |t|
      t.belongs_to :department
      t.string :name, null: false
      t.integer :academic_degree, default: 0

      t.timestamps
    end
  end
end
