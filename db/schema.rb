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

ActiveRecord::Schema[8.1].define(version: 2026_05_04_002414) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "contacts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", null: false
    t.bigint "job_application_id", null: false
    t.string "name", null: false
    t.text "note"
    t.string "phone_number"
    t.datetime "updated_at", null: false
    t.index ["job_application_id"], name: "index_contacts_on_job_application_id"
  end

  create_table "follow_ups", force: :cascade do |t|
    t.boolean "completed", default: false
    t.datetime "completed_at"
    t.datetime "created_at", null: false
    t.bigint "job_application_id", null: false
    t.string "message"
    t.datetime "remind_at", null: false
    t.datetime "updated_at", null: false
    t.index ["completed"], name: "index_follow_ups_on_completed"
    t.index ["job_application_id"], name: "index_follow_ups_on_job_application_id"
    t.index ["remind_at"], name: "index_follow_ups_on_remind_at"
  end

  create_table "job_applications", force: :cascade do |t|
    t.date "applied_date"
    t.string "company_name", null: false
    t.datetime "created_at", null: false
    t.text "job_description"
    t.string "job_title", null: false
    t.string "job_url"
    t.string "location"
    t.text "notes"
    t.boolean "remote", default: false
    t.integer "salary_max"
    t.integer "salary_min"
    t.integer "status", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["applied_date"], name: "index_job_applications_on_applied_date"
    t.index ["status"], name: "index_job_applications_on_status"
    t.index ["user_id"], name: "index_job_applications_on_user_id"
  end

  create_table "status_histories", force: :cascade do |t|
    t.datetime "changed_at"
    t.datetime "created_at", null: false
    t.bigint "job_application_id", null: false
    t.integer "new_status"
    t.string "notes"
    t.integer "previous_status"
    t.datetime "updated_at", null: false
    t.index ["job_application_id"], name: "index_status_histories_on_job_application_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "password_digest", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "contacts", "job_applications"
  add_foreign_key "follow_ups", "job_applications"
  add_foreign_key "job_applications", "users"
  add_foreign_key "status_histories", "job_applications"
end
