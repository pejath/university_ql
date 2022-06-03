class CreateGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :groups do |t|
      t.belongs_to :department
      t.belongs_to :curator, foreign_key: { to_table: :lecturers }
      t.integer :specialization_code, null: false
      t.integer :course, null: false
      t.integer :form_of_education, null: false

      t.timestamps
    end
  end
end
