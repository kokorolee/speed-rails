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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180222022323) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.integer "trackable_type"
    t.integer "trackable_id"
    t.integer "owner_type"
    t.integer "owner_id"
    t.string "key"
    t.string "parameters"
    t.integer "recipient_type"
    t.integer "recipient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "attactments", id: :serial, force: :cascade do |t|
    t.integer "owner_id"
    t.string "table"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "check_lists", force: :cascade do |t|
    t.string "name"
    t.text "desc"
    t.integer "todo_list_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "team_id"
  end

  create_table "comments", force: :cascade do |t|
    t.integer "user_id"
    t.integer "todo_id"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "importank"
    t.string "files"
  end

  create_table "customers", id: :serial, force: :cascade do |t|
    t.string "code"
    t.string "fullname"
    t.integer "title"
    t.string "phone_number"
    t.string "email"
    t.integer "source_id"
    t.boolean "private"
    t.integer "assign_user_id"
    t.integer "state_id"
    t.integer "status"
    t.string "note"
    t.integer "created_by"
    t.integer "updated_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "group_id"
  end

  create_table "customers_partners", id: false, force: :cascade do |t|
    t.integer "customer_id"
    t.integer "partner_id"
    t.index ["customer_id"], name: "index_customers_partners_on_customer_id"
    t.index ["partner_id"], name: "index_customers_partners_on_partner_id"
  end

  create_table "customers_products", id: false, force: :cascade do |t|
    t.integer "customer_id"
    t.integer "product_id"
    t.index ["customer_id"], name: "index_customers_products_on_customer_id"
    t.index ["product_id"], name: "index_customers_products_on_product_id"
  end

  create_table "data", force: :cascade do |t|
    t.integer "todo_id"
    t.string "files"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "group_properties", id: :serial, force: :cascade do |t|
    t.string "name", default: "", null: false
    t.integer "status", default: 1, null: false
    t.string "group_type", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "updated_by"
    t.integer "created_by"
  end

  create_table "groups", id: :serial, force: :cascade do |t|
    t.integer "label"
    t.string "name"
    t.string "intro"
    t.string "warning"
    t.integer "status", default: 1, null: false
    t.boolean "can_modify", default: true, null: false
    t.boolean "can_delete", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "color"
  end

  create_table "notes", id: :serial, force: :cascade do |t|
    t.text "message"
    t.integer "owner_id"
    t.string "table"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.string "event"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "parent_id"
    t.string "category"
    t.integer "user_id"
    t.string "url"
    t.integer "team_id"
    t.string "view_user_id"
  end

  create_table "order_items", id: :serial, force: :cascade do |t|
    t.integer "order_id", null: false
    t.integer "product_id", null: false
    t.integer "qty", default: 1, null: false
    t.integer "user_id"
    t.float "amount", default: 0.0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", id: :serial, force: :cascade do |t|
    t.integer "customer_id"
    t.string "order_no"
    t.string "order_date"
    t.integer "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "total_amount"
    t.integer "discount_type"
    t.float "real_amount"
    t.float "discount_value"
  end

  create_table "partner_types", id: :serial, force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "desc", default: "", null: false
    t.float "reduction", default: 0.0, null: false
    t.string "condition", default: "", null: false
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "partners", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "fullname", default: "", null: false
    t.string "phone", default: "", null: false
    t.string "city", default: "", null: false
    t.string "province", default: "", null: false
    t.string "address", default: "", null: false
    t.string "personal_id", default: "", null: false
    t.integer "partner_type_id", null: false
    t.string "access_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_partners_on_email", unique: true
    t.index ["reset_password_token"], name: "index_partners_on_reset_password_token", unique: true
  end

  create_table "permissions", id: :serial, force: :cascade do |t|
    t.string "action"
    t.string "subject_class"
    t.integer "subject_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "permissions_roles", id: false, force: :cascade do |t|
    t.integer "permission_id"
    t.integer "role_id"
    t.index ["permission_id"], name: "index_permissions_roles_on_permission_id"
    t.index ["role_id"], name: "index_permissions_roles_on_role_id"
  end

  create_table "products", id: :serial, force: :cascade do |t|
    t.string "name", default: "", null: false
    t.integer "product_type", default: 1, null: false
    t.integer "created_by"
    t.integer "updated_by"
    t.integer "user_id", default: 0
    t.float "price", default: 0.0
    t.float "discount_price", default: 0.0, null: false
    t.integer "status", default: 1, null: false
    t.integer "category_id", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "reduction"
  end

  create_table "products_orders", id: :serial, force: :cascade do |t|
    t.integer "product_id"
    t.integer "order_id"
    t.index ["order_id"], name: "index_products_orders_on_order_id"
    t.index ["product_id"], name: "index_products_orders_on_product_id"
  end

  create_table "products_users", id: :serial, force: :cascade do |t|
    t.integer "product_id"
    t.integer "user_id"
    t.index ["product_id"], name: "index_products_users_on_product_id"
    t.index ["user_id"], name: "index_products_users_on_user_id"
  end

  create_table "properties", id: :serial, force: :cascade do |t|
    t.string "name", default: "", null: false
    t.integer "group_property_id", null: false
    t.integer "property_type", default: 1, null: false
    t.boolean "property_required", default: false, null: false
    t.integer "status", default: 1, null: false
    t.boolean "can_modify", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "updated_by"
    t.integer "created_by"
    t.string "internal_name"
    t.string "intro"
    t.string "color"
  end

  create_table "property_matches", id: :serial, force: :cascade do |t|
    t.integer "object_id"
    t.integer "property_id"
    t.string "property_key"
    t.string "property_value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.json "photo"
  end

  create_table "roles", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "desc"
  end

  create_table "roles_users", id: false, force: :cascade do |t|
    t.integer "role_id"
    t.integer "user_id"
    t.index ["role_id"], name: "index_roles_users_on_role_id"
    t.index ["user_id"], name: "index_roles_users_on_user_id"
  end

  create_table "step_check_lists", force: :cascade do |t|
    t.string "name"
    t.integer "check_list_id"
    t.integer "no"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "step_workflows", force: :cascade do |t|
    t.string "parent_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "workflow_id"
    t.float "estimate"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.text "desc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "archived"
  end

  create_table "teams_users", id: :serial, force: :cascade do |t|
    t.integer "team_id"
    t.integer "user_id"
    t.index ["team_id"], name: "index_teams_users_on_team_id"
    t.index ["user_id"], name: "index_teams_users_on_user_id"
  end

  create_table "todo_check_lists", force: :cascade do |t|
    t.string "todo_id"
    t.integer "step_check_list_id"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "todo_lists", force: :cascade do |t|
    t.integer "parent_id"
    t.string "name"
    t.text "desc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "team_id"
    t.integer "type"
    t.boolean "archived"
    t.string "slug"
    t.integer "category"
    t.string "hash_tag"
  end

  create_table "todos", force: :cascade do |t|
    t.integer "todo_list_id"
    t.integer "check_list_id"
    t.integer "type"
    t.string "name"
    t.text "desc"
    t.datetime "created_by"
    t.datetime "updated_by"
    t.integer "status"
    t.datetime "due_date"
    t.integer "completed_at"
    t.string "files"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "position", default: 0
    t.string "slug"
    t.float "estimate", default: 0.0, null: false
    t.boolean "archived"
    t.integer "user_id"
    t.integer "category"
    t.integer "step_id"
    t.integer "parent_id"
    t.string "location"
    t.string "data_check_list"
    t.integer "private"
  end

  create_table "todos_users", id: :serial, force: :cascade do |t|
    t.integer "todo_id"
    t.integer "user_id"
    t.index ["todo_id"], name: "index_todos_users_on_todo_id"
    t.index ["user_id"], name: "index_todos_users_on_user_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "phone", default: "", null: false
    t.string "fullname", default: ""
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "updated_by"
    t.integer "created_by"
    t.integer "role_id"
    t.integer "super_role"
    t.string "avatar"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_roles", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

  create_table "workflows", force: :cascade do |t|
    t.string "name"
    t.integer "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "archived"
  end

end
