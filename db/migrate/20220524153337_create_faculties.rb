class CreateFaculties < ActiveRecord::Migration[6.1]
  def change
    create_table :faculties do |t|
      t.string :name
      t.date :formation_date

      t.timestamps
    end
  end
end
