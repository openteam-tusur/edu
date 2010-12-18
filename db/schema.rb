# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20101217112705) do

  create_table "chairs", :force => true do |t|
    t.integer  "faculty_id"
    t.string   "name"
    t.string   "abbr"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "examinations", :force => true do |t|
    t.string   "slug"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "faculties", :force => true do |t|
    t.string   "name"
    t.string   "abbr"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "specialities", :force => true do |t|
    t.string   "name"
    t.string   "degree"
    t.string   "qualification"
    t.integer  "chair_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "code"
    t.string   "state"
  end

  create_table "speciality_accreditations", :force => true do |t|
    t.integer  "speciality_id"
    t.string   "number"
    t.date     "issued_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "speciality_disciplines", :force => true do |t|
    t.text     "name"
    t.integer  "speciality_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "speciality_educations", :force => true do |t|
    t.integer  "speciality_semester_id"
    t.integer  "speciality_discipline_id"
    t.integer  "loading_lecture"
    t.integer  "loading_laboratory"
    t.integer  "loading_practice"
    t.integer  "loading_course_project"
    t.integer  "loading_course_work"
    t.integer  "loading_self_training"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "speciality_licences", :force => true do |t|
    t.integer  "speciality_id"
    t.string   "number"
    t.date     "issued_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "speciality_semesters", :force => true do |t|
    t.integer  "speciality_id"
    t.integer  "number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
