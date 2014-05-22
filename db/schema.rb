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

ActiveRecord::Schema.define(version: 20140520150726) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "brokertypes", force: true do |t|
    t.string   "brokertype"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dockerservers", force: true do |t|
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rhcbranches", force: true do |t|
    t.string   "branch"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "runbranches", force: true do |t|
    t.integer  "run_id"
    t.integer  "rhcbranch_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "runbrokers", force: true do |t|
    t.integer  "run_id"
    t.integer  "brokertypes_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table :runs do |t|
    t.string :broker
    t.string :testrun_id
#    t.string :caserun_ids, :array => true, :default => '{}'
#    t.string :accounts, :array => true, :default => '{}'
    t.string :caserun_ids
    t.string :accounts
    t.integer :job_count
    t.integer :max_gears
    t.boolean :debug
    t.string :tcms_user
    t.string :tcms_password
    t.integer :accounts_per_job
    t.integer :rhcbranch, :references => :rhcbranch
    t.integer :brokertype, :references => :brokertype 
    t.string :docker_url, :references => :dockerserver
    t.string :image_url
    t.timestamps
  end


end
