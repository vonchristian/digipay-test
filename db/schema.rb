# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_11_02_102717) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "accounts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.boolean "contra"
    t.string "type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["code"], name: "index_accounts_on_code", unique: true
    t.index ["name"], name: "index_accounts_on_name", unique: true
    t.index ["type"], name: "index_accounts_on_type"
  end

  create_table "agents", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "account_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.uuid "credential_id", null: false
    t.index ["credential_id"], name: "index_agents_on_credential_id"
  end

  create_table "amounts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "account_id"
    t.uuid "entry_id"
    t.integer "amount_cents", default: 0, null: false
    t.string "amount_currency", default: "USD", null: false
    t.string "type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id", "entry_id"], name: "index_amounts_on_account_id_and_entry_id"
    t.index ["account_id"], name: "index_amounts_on_account_id"
    t.index ["entry_id", "account_id"], name: "index_amounts_on_entry_id_and_account_id"
    t.index ["entry_id"], name: "index_amounts_on_entry_id"
    t.index ["type"], name: "index_amounts_on_type"
  end

  create_table "credentials", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["confirmation_token"], name: "index_credentials_on_confirmation_token", unique: true
    t.index ["email"], name: "index_credentials_on_email", unique: true
    t.index ["reset_password_token"], name: "index_credentials_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_credentials_on_unlock_token", unique: true
  end

  create_table "customers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "entries", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "reference_number"
    t.datetime "entry_date"
    t.time "entry_time"
    t.string "commercial_document_type", null: false
    t.bigint "commercial_document_id", null: false
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["commercial_document_type", "commercial_document_id"], name: "index_commercial_document_on_entries"
  end

  create_table "financial_institutions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "category"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category"], name: "index_financial_institutions_on_category"
  end

  create_table "virtual_money_accounts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "depositor_type", null: false
    t.uuid "depositor_id", null: false
    t.string "account_number"
    t.uuid "liability_account_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_number"], name: "index_virtual_money_accounts_on_account_number", unique: true
    t.index ["depositor_type", "depositor_id"], name: "index_virtual_money_accounts_on_depositor_type_and_depositor_id"
    t.index ["liability_account_id"], name: "index_virtual_money_accounts_on_liability_account_id"
  end

  create_table "voucher_amounts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "type"
    t.uuid "account_id", null: false
    t.integer "amount_cents", default: 0, null: false
    t.string "amount_currency", default: "USD", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_voucher_amounts_on_account_id"
    t.index ["type"], name: "index_voucher_amounts_on_type"
  end

  create_table "vouchers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "reference_number"
    t.datetime "entry_date"
    t.time "entry_time"
    t.uuid "entry_id"
    t.string "commercial_document_type", null: false
    t.uuid "commercial_document_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "origination_type", null: false
    t.uuid "origination_id", null: false
    t.index ["commercial_document_type", "commercial_document_id"], name: "index_commercial_document_on_vouchers"
    t.index ["entry_id"], name: "index_vouchers_on_entry_id"
    t.index ["origination_type", "origination_id"], name: "index_vouchers_on_origination_type_and_origination_id"
  end

  create_table "wallets", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.uuid "virtual_money_account_id", null: false
    t.uuid "account_owner_id", null: false
    t.string "account_number", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_owner_id"], name: "index_wallets_on_account_owner_id"
    t.index ["virtual_money_account_id"], name: "index_wallets_on_virtual_money_account_id"
  end

  add_foreign_key "agents", "credentials"
  add_foreign_key "amounts", "accounts"
  add_foreign_key "amounts", "entries"
  add_foreign_key "virtual_money_accounts", "accounts", column: "liability_account_id"
  add_foreign_key "voucher_amounts", "accounts"
  add_foreign_key "vouchers", "entries"
  add_foreign_key "wallets", "virtual_money_accounts"
end
