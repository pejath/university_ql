# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_05_24_153750) do

  create_table "departments", force: :cascade do |t|
    t.integer "faculty_id"
    t.string "name", null: false
    t.integer "department_type", null: false
    t.date "formation_date", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["faculty_id"], name: "index_departments_on_faculty_id"
  end

  create_table "faculties", force: :cascade do |t|
    t.string "name"
    t.date "formation_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_faculties_on_name", unique: true
  end

  create_table "groups", force: :cascade do |t|
    t.integer "department_id"
    t.integer "curator_id"
    t.integer "specialization_code", null: false
    t.integer "course", null: false
    t.integer "form_of_education", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["curator_id"], name: "index_groups_on_curator_id"
    t.index ["department_id"], name: "index_groups_on_department_id"
  end

  create_table "lecture_times", force: :cascade do |t|
    t.time "beginning"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "lecturers", force: :cascade do |t|
    t.integer "department_id"
    t.string "name", null: false
    t.integer "academic_degree"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["department_id"], name: "index_lecturers_on_department_id"
  end

  create_table "lecturers_subjects", force: :cascade do |t|
    t.integer "lecturer_id"
    t.integer "subject_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["lecturer_id", "subject_id"], name: "index_lecturers_subjects_on_lecturer_id_and_subject_id", unique: true
    t.index ["lecturer_id"], name: "index_lecturers_subjects_on_lecturer_id"
    t.index ["subject_id"], name: "index_lecturers_subjects_on_subject_id"
  end

  create_table "lectures", force: :cascade do |t|
    t.integer "lecture_time_id"
    t.integer "group_id"
    t.integer "lecturer_id"
    t.integer "subject_id"
    t.integer "weekday", null: false
    t.integer "corpus", null: false
    t.integer "auditorium", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["corpus", "auditorium", "lecture_time_id", "group_id", "lecturer_id", "weekday"], name: "lecture_index", unique: true
    t.index ["group_id"], name: "index_lectures_on_group_id"
    t.index ["lecture_time_id"], name: "index_lectures_on_lecture_time_id"
    t.index ["lecturer_id"], name: "index_lectures_on_lecturer_id"
    t.index ["subject_id"], name: "index_lectures_on_subject_id"
  end

  create_table "marks", force: :cascade do |t|
    t.integer "student_id"
    t.integer "subject_id"
    t.integer "lecturer_id"
    t.integer "mark", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["lecturer_id"], name: "index_marks_on_lecturer_id"
    t.index ["student_id"], name: "index_marks_on_student_id"
    t.index ["subject_id"], name: "index_marks_on_subject_id"
  end

  create_table "students", force: :cascade do |t|
    t.integer "group_id"
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["group_id"], name: "index_students_on_group_id"
  end

  create_table "subjects", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "groups", "lecturers", column: "curator_id"
end
