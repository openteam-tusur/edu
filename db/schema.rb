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

ActiveRecord::Schema.define(:version => 20101221031805) do

  create_table "chairs", :force => true do |t|
    t.integer  "faculty_id"
    t.string   "name"
    t.string   "abbr"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "educations_examinations", :id => false, :force => true do |t|
    t.integer  "education_id"
    t.integer  "examination_id"
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

  create_table "humen", :force => true do |t|
    t.integer  "user_id"
    t.string   "surname"
    t.string   "name"
    t.string   "patronymic"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "plan_accreditations", :force => true do |t|
    t.integer  "speciality_id"
    t.string   "number"
    t.date     "issued_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "plan_curriculums", :force => true do |t|
    t.string   "study"
    t.integer  "speciality_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state"
  end

  create_table "plan_disciplines", :force => true do |t|
    t.text     "name"
    t.integer  "speciality_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "plan_educations", :force => true do |t|
    t.integer  "semester_id"
    t.integer  "discipline_id"
    t.integer  "loading_lecture"
    t.integer  "loading_laboratory"
    t.integer  "loading_practice"
    t.integer  "loading_course_project"
    t.integer  "loading_course_work"
    t.integer  "loading_self_training"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "plan_licences", :force => true do |t|
    t.integer  "speciality_id"
    t.string   "number"
    t.date     "issued_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "plan_semesters", :force => true do |t|
    t.integer  "curriculum_id"
    t.integer  "number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", :force => true do |t|
    t.integer  "human_id"
    t.string   "title"
    t.string   "slug"
    t.string   "type"
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
  end

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "password_salt",                       :default => "", :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
