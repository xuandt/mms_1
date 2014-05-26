ActiveRecord::Schema.define(version: 20140526025354) do

  create_table "activities", force: true do |t|
    t.datetime "time"
    t.string   "action"
    t.integer  "member"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "member_projects", force: true do |t|
    t.integer  "member_id"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "member_skills", force: true do |t|
    t.integer  "member_id"
    t.integer  "skill_id"
    t.integer  "level"
    t.integer  "used_years"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "members", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.date     "birthday"
    t.string   "password_digest"
    t.integer  "team_id"
    t.integer  "position_id"
    t.integer  "project_id"
    t.boolean  "admin",           default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
  end

  add_index "members", ["email"], name: "index_members_on_email", unique: true, using: :btree
  add_index "members", ["remember_token"], name: "index_members_on_remember_token", using: :btree

  create_table "positions", force: true do |t|
    t.string   "name"
    t.string   "short_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", force: true do |t|
    t.string   "name"
    t.string   "shortname"
    t.date     "start_date"
    t.date     "end_date"
    t.string   "project_leader"
    t.integer  "team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "skills", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teams", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "teamleader"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end