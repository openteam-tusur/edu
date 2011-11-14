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

ActiveRecord::Schema.define(:version => 20111107084400) do

  create_table "accreditations", :force => true do |t|
    t.integer  "speciality_id"
    t.string   "number"
    t.date     "issued_on"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "attachments", :force => true do |t|
    t.string   "data_uid"
    t.integer  "resource_id"
    t.string   "data_file_name"
    t.integer  "data_file_size"
    t.string   "data_content_type"
    t.datetime "data_updated_at"
    t.string   "data_hash"
    t.string   "resource_type"
  end

  create_table "authors", :force => true do |t|
    t.integer  "resource_id"
    t.string   "resource_type"
    t.integer  "human_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "chairs", :force => true do |t|
    t.integer  "faculty_id"
    t.string   "name"
    t.string   "abbr"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "curriculums", :force => true do |t|
    t.string   "study_form"
    t.integer  "speciality_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state"
    t.integer  "year"
    t.string   "access"
    t.integer  "since"
    t.integer  "volume"
    t.integer  "chair_id"
    t.string   "profile"
  end

  create_table "cycles", :force => true do |t|
    t.string   "code"
    t.string   "name"
    t.string   "degree"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "disciplines", :force => true do |t|
    t.text     "name"
    t.integer  "speciality_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "disks", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "released_on"
  end

  create_table "educations", :force => true do |t|
    t.integer  "semester_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "study_id"
  end

  create_table "educations_examinations", :id => false, :force => true do |t|
    t.integer "education_id"
    t.integer "examination_id"
  end

  create_table "educations_publication_disciplines", :id => false, :force => true do |t|
    t.integer "education_id"
    t.integer "publication_discipline_id"
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

  create_table "humans", :force => true do |t|
    t.integer  "user_id"
    t.string   "surname"
    t.string   "name"
    t.string   "patronymic"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "issues", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "data_file_name"
    t.integer  "data_file_size"
    t.string   "data_content_type"
    t.datetime "data_updated_at"
    t.string   "data_hash"
    t.integer  "disk_id"
    t.text     "import_report"
  end

  create_table "licences", :force => true do |t|
    t.integer  "speciality_id"
    t.string   "number"
    t.date     "issued_on"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "main_subjects", :force => true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "code"
  end

  create_table "months", :force => true do |t|
    t.string   "title"
    t.integer  "year_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "publication_disciplines", :force => true do |t|
    t.integer  "publication_id"
    t.integer  "discipline_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "publications", :force => true do |t|
    t.integer  "chair_id"
    t.string   "title"
    t.integer  "year"
    t.integer  "volume"
    t.string   "state"
    t.string   "access"
    t.string   "kind"
    t.string   "isbn"
    t.string   "udk"
    t.string   "bbk"
    t.text     "stamp"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "content"
    t.text     "annotation"
    t.string   "extended_kind"
    t.text     "comment"
  end

  create_table "records", :force => true do |t|
    t.text     "fields"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "issue_id"
    t.integer  "subject_id"
    t.integer  "month_id"
  end

  create_table "roles", :force => true do |t|
    t.integer  "human_id"
    t.string   "title"
    t.string   "slug"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state"
    t.string   "group"
    t.date     "birthday"
    t.integer  "chair_id"
    t.string   "post"
    t.integer  "contingent_id"
  end

  create_table "semesters", :force => true do |t|
    t.integer  "curriculum_id"
    t.integer  "number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "specialities", :force => true do |t|
    t.string   "name"
    t.string   "degree"
    t.string   "qualification"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "code"
  end

  create_table "studies", :force => true do |t|
    t.integer  "chair_id"
    t.integer  "curriculum_id"
    t.integer  "discipline_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "cycle_id"
  end

  create_table "subjects", :force => true do |t|
    t.string   "code"
    t.string   "title"
    t.integer  "main_subject_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "used_books", :force => true do |t|
    t.text     "title"
    t.string   "kind"
    t.integer  "publication_id"
    t.string   "library_code"
    t.integer  "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "publication_code"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
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

  create_table "years", :force => true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
