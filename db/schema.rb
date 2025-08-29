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

ActiveRecord::Schema[8.0].define(version: 2025_08_28_234817) do
  create_table "clients", force: :cascade do |t|
    t.string "name"
    t.string "document_number"
    t.string "phone_number"
    t.integer "workshop_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["workshop_id"], name: "index_clients_on_workshop_id"
  end

  create_table "conversations", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "super_admin_id", null: false
    t.string "status", default: "open"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["super_admin_id"], name: "index_conversations_on_super_admin_id"
    t.index ["user_id"], name: "index_conversations_on_user_id"
  end

  create_table "entry_orders", force: :cascade do |t|
    t.text "problem_description"
    t.integer "mileage"
    t.integer "fuel_level"
    t.integer "oil_level"
    t.text "visual_inspection_chassis"
    t.text "tires_condition"
    t.boolean "front_light_status", default: false
    t.boolean "turn_signals_status", default: false
    t.boolean "brake_lights_status", default: false
    t.boolean "horn_status", default: false
    t.text "battery_status"
    t.text "drive_chain_status"
    t.text "front_brake_status"
    t.text "rear_brake_status"
    t.text "throttle_cable_status"
    t.text "clutch_cable_status"
    t.text "engine_start_status"
    t.text "engine_idle_status"
    t.text "engine_accelerating_status"
    t.text "notes"
    t.integer "intervention_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["intervention_id"], name: "index_entry_orders_on_intervention_id"
  end

  create_table "interventions", force: :cascade do |t|
    t.datetime "entry_date"
    t.datetime "output_date"
    t.string "status"
    t.integer "motorcycle_id", null: false
    t.integer "workshop_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["motorcycle_id"], name: "index_interventions_on_motorcycle_id"
    t.index ["workshop_id"], name: "index_interventions_on_workshop_id"
  end

  create_table "messages", force: :cascade do |t|
    t.integer "conversation_id", null: false
    t.integer "sender_id", null: false
    t.text "content", null: false
    t.boolean "read", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["conversation_id"], name: "index_messages_on_conversation_id"
    t.index ["sender_id"], name: "index_messages_on_sender_id"
  end

  create_table "motorcycles", force: :cascade do |t|
    t.string "license_plate"
    t.string "brand"
    t.string "model"
    t.integer "year"
    t.integer "client_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_motorcycles_on_client_id"
  end

  create_table "output_sheets", force: :cascade do |t|
    t.integer "mileage"
    t.integer "fuel_level"
    t.integer "oil_level"
    t.text "notes"
    t.text "repaired_parts"
    t.text "disclaimer"
    t.integer "intervention_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["intervention_id"], name: "index_output_sheets_on_intervention_id"
  end

  create_table "plans", force: :cascade do |t|
    t.string "name", null: false
    t.decimal "price", null: false
    t.integer "duration", null: false
    t.text "details"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "procedure_sheets", force: :cascade do |t|
    t.text "content"
    t.integer "intervention_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["intervention_id"], name: "index_procedure_sheets_on_intervention_id"
    t.index ["user_id"], name: "index_procedure_sheets_on_user_id"
  end

  create_table "services", force: :cascade do |t|
    t.string "name"
    t.text "description", default: ""
    t.decimal "price"
    t.integer "workshop_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["workshop_id"], name: "index_services_on_workshop_id"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "plan_id", null: false
    t.string "wompi_transaction_id"
    t.datetime "start_date"
    t.datetime "end_date"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plan_id"], name: "index_subscriptions_on_plan_id"
    t.index ["user_id"], name: "index_subscriptions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "document_number"
    t.string "phone_number"
    t.boolean "is_super_admin", default: false
    t.boolean "is_admin", default: false
    t.boolean "is_mechanic", default: false
    t.boolean "status", default: true
    t.integer "workshop_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["workshop_id"], name: "index_users_on_workshop_id"
  end

  create_table "workshops", force: :cascade do |t|
    t.string "name"
    t.string "phone"
    t.string "city"
    t.string "address"
    t.text "details"
    t.string "opening_hours"
    t.string "unique_profile_link"
    t.boolean "status", default: true
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_workshops_on_user_id"
  end

  add_foreign_key "clients", "workshops"
  add_foreign_key "conversations", "users"
  add_foreign_key "conversations", "users", column: "super_admin_id"
  add_foreign_key "entry_orders", "interventions"
  add_foreign_key "interventions", "motorcycles"
  add_foreign_key "interventions", "workshops"
  add_foreign_key "messages", "conversations"
  add_foreign_key "messages", "users", column: "sender_id"
  add_foreign_key "motorcycles", "clients"
  add_foreign_key "output_sheets", "interventions"
  add_foreign_key "procedure_sheets", "interventions"
  add_foreign_key "procedure_sheets", "users"
  add_foreign_key "services", "workshops"
  add_foreign_key "subscriptions", "plans"
  add_foreign_key "subscriptions", "users"
  add_foreign_key "users", "workshops"
  add_foreign_key "workshops", "users"
end
