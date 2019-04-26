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

ActiveRecord::Schema.define(version: 2019_04_17_163914) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "caixas", force: :cascade do |t|
    t.integer "tipo_lancamento"
    t.decimal "valor", precision: 14, scale: 2, default: "0.0"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_caixas_on_user_id"
  end

  create_table "categoria", force: :cascade do |t|
    t.string "nome"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "ativo", default: true
  end

  create_table "lancamentos", force: :cascade do |t|
    t.string "descricao"
    t.date "data_vencimento"
    t.date "data_pagamento"
    t.decimal "valor", precision: 14, scale: 2, default: "0.0"
    t.string "observacao"
    t.bigint "categoria_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "tipo"
    t.boolean "ativo", default: true
    t.bigint "pessoa_id"
    t.boolean "movimenta_caixa", default: true
    t.boolean "condominio", default: false
    t.integer "caixa_id"
    t.index ["categoria_id"], name: "index_lancamentos_on_categoria_id"
    t.index ["pessoa_id"], name: "index_lancamentos_on_pessoa_id"
  end

  create_table "perfil_regra_acessos", force: :cascade do |t|
    t.string "controller"
    t.string "action"
    t.bigint "perfil_id"
    t.string "description"
    t.boolean "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["perfil_id"], name: "index_perfil_regra_acessos_on_perfil_id"
  end

  create_table "perfils", force: :cascade do |t|
    t.string "nome"
    t.string "descricao"
    t.integer "codigo"
    t.integer "status", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pessoas", force: :cascade do |t|
    t.string "nome"
    t.string "numero"
    t.string "bloco"
    t.boolean "ativo", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "relatorios", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "tipo_relatorio"
    t.date "data_inicio"
    t.date "date_fim"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_relatorios_on_user_id"
  end

  create_table "system_configs", force: :cascade do |t|
    t.boolean "installed", default: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.integer "perfil_id"
    t.integer "pessoa_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  create_table "vencimentos", force: :cascade do |t|
    t.bigint "pessoa_id"
    t.date "data"
    t.date "data_vencimento"
    t.integer "status"
    t.decimal "valor", precision: 14, scale: 2, default: "0.0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pessoa_id"], name: "index_vencimentos_on_pessoa_id"
  end

  add_foreign_key "caixas", "users"
  add_foreign_key "lancamentos", "categoria", column: "categoria_id"
  add_foreign_key "lancamentos", "pessoas"
  add_foreign_key "perfil_regra_acessos", "perfils"
  add_foreign_key "relatorios", "users"
  add_foreign_key "vencimentos", "pessoas"
end
