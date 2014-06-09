# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20140602061459) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "brokertypes", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dockerservers", force: true do |t|
    t.string   "name"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "images", force: true do |t|
    t.string   "uuid"
    t.string   "tag"
    t.integer  "dockerserver_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "images", ["dockerserver_id"], name: "index_images_on_dockerserver_id", using: :btree

  create_table "logservers", force: true do |t|
    t.string   "hostname"
    t.string   "username"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rhcbranches", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rundockerservers", force: true do |t|
    t.integer  "run_id"
    t.integer  "dockerserver_id"
    t.integer  "image_id"
    t.integer  "jobcount"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rundockerservers", ["dockerserver_id"], name: "index_rundockerservers_on_dockerserver_id", using: :btree
  add_index "rundockerservers", ["image_id"], name: "index_rundockerservers_on_image_id", using: :btree
  add_index "rundockerservers", ["run_id"], name: "index_rundockerservers_on_run_id", using: :btree

  create_table "runlogservers", force: true do |t|
    t.integer  "run_id"
    t.integer  "logserver_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "runlogservers", ["logserver_id"], name: "index_runlogservers_on_logserver_id", using: :btree
  add_index "runlogservers", ["run_id"], name: "index_runlogservers_on_run_id", using: :btree

  create_table "runs", force: true do |t|
    t.string   "broker"
    t.integer  "testrun"
    t.string   "caseruns"
    t.string   "accounts"
    t.integer  "maxgears"
    t.string   "tcms_user"
    t.string   "tcms_password"
    t.integer  "rhcbranch_id"
    t.integer  "brokertype_id"
    t.integer  "accounts_per_job"
    t.integer  "logserver_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "runs", ["brokertype_id"], name: "index_runs_on_brokertype_id", using: :btree
  add_index "runs", ["logserver_id"], name: "index_runs_on_logserver_id", using: :btree
  add_index "runs", ["rhcbranch_id"], name: "index_runs_on_rhcbranch_id", using: :btree

end
