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

ActiveRecord::Schema.define(version: 2021_12_25_192347) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "calibrations", force: :cascade do |t|
    t.bigint "instrument_id", null: false
    t.date "date", null: false
    t.string "laboratory"
    t.string "certificate_number"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["date"], name: "index_calibrations_on_date"
    t.index ["instrument_id"], name: "index_calibrations_on_instrument_id"
  end

  create_table "client_groups", force: :cascade do |t|
    t.string "description", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["description"], name: "index_client_groups_on_description", unique: true, where: "(deleted_at IS NULL)"
  end

  create_table "clients", force: :cascade do |t|
    t.string "cpf_cnpj", null: false
    t.string "company_name", null: false
    t.string "trading_name"
    t.string "document_number"
    t.string "email"
    t.string "phone"
    t.string "cel_phone"
    t.boolean "active", default: true, null: false
    t.bigint "client_group_id"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "password_digest"
    t.string "session_token"
    t.index ["client_group_id"], name: "index_clients_on_client_group_id"
    t.index ["cpf_cnpj"], name: "index_clients_on_cpf_cnpj", unique: true, where: "(deleted_at IS NULL)"
    t.index ["created_at"], name: "index_clients_on_created_at"
  end

  create_table "companies", force: :cascade do |t|
    t.string "company_name", null: false
    t.string "trading_name"
    t.string "cpf_cnpj", null: false
    t.string "tenant_name", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["tenant_name"], name: "index_companies_on_tenant_name", unique: true
  end

  create_table "instruments", force: :cascade do |t|
    t.bigint "client_id", null: false
    t.string "tag", null: false
    t.string "description", null: false
    t.integer "calibration_time", default: 0, null: false
    t.string "responsible"
    t.string "area"
    t.string "subarea"
    t.string "manufacturer"
    t.string "serial_number"
    t.string "range"
    t.string "resolution"
    t.boolean "active", default: true, null: false
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["client_id"], name: "index_instruments_on_client_id"
    t.index ["created_at"], name: "index_instruments_on_created_at"
    t.index ["description"], name: "index_instruments_on_description"
    t.index ["tag"], name: "index_instruments_on_tag"
  end

  create_table "users", force: :cascade do |t|
    t.bigint "company_id", null: false
    t.string "name", null: false
    t.string "email", null: false
    t.string "password_digest"
    t.boolean "active", default: true
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "is_admin", default: false
    t.string "session_token"
    t.index ["company_id"], name: "index_users_on_company_id"
    t.index ["email"], name: "index_users_on_email", unique: true, where: "(deleted_at IS NULL)"
  end

  add_foreign_key "calibrations", "instruments"
  add_foreign_key "clients", "client_groups"
  add_foreign_key "instruments", "clients"
  add_foreign_key "users", "companies"
end
