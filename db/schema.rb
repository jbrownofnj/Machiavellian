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

ActiveRecord::Schema[7.0].define(version: 2022_12_11_210500) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "constructions", force: :cascade do |t|
    t.bigint "player_id", null: false
    t.bigint "round_id", null: false
    t.string "construction_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["player_id"], name: "index_constructions_on_player_id"
    t.index ["round_id"], name: "index_constructions_on_round_id"
  end

  create_table "fund_request_responses", force: :cascade do |t|
    t.bigint "funding_request_id", null: false
    t.bigint "funding_request_player_role_id", null: false
    t.string "funding_request_response_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["funding_request_id"], name: "index_fund_request_responses_on_funding_request_id"
    t.index ["funding_request_player_role_id"], name: "index_fund_request_responses_on_funding_request_player_role_id"
  end

  create_table "funding_request_player_roles", force: :cascade do |t|
    t.bigint "player_id", null: false
    t.bigint "funding_request_id", null: false
    t.string "player_role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["funding_request_id"], name: "index_funding_request_player_roles_on_funding_request_id"
    t.index ["player_id"], name: "index_funding_request_player_roles_on_player_id"
  end

  create_table "funding_request_resources", force: :cascade do |t|
    t.bigint "funding_request_id", null: false
    t.string "funding_resource_type"
    t.integer "funding_resource_amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["funding_request_id"], name: "index_funding_request_resources_on_funding_request_id"
  end

  create_table "funding_requests", force: :cascade do |t|
    t.bigint "round_id", null: false
    t.bigint "construction_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["construction_id"], name: "index_funding_requests_on_construction_id"
    t.index ["round_id"], name: "index_funding_requests_on_round_id"
  end

  create_table "fundings", force: :cascade do |t|
    t.bigint "construction_id", null: false
    t.string "funding_resource_type"
    t.integer "funding_resource_amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["construction_id"], name: "index_fundings_on_construction_id"
  end

  create_table "games", force: :cascade do |t|
    t.string "game_name"
    t.string "password_digest", null: false
    t.boolean "finished", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "gather_informations", force: :cascade do |t|
    t.bigint "player_action_id", null: false
    t.bigint "player_id", null: false
    t.string "information_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["player_action_id"], name: "index_gather_informations_on_player_action_id"
    t.index ["player_id"], name: "index_gather_informations_on_player_id"
  end

  create_table "matches", force: :cascade do |t|
    t.bigint "game_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_matches_on_game_id"
  end

  create_table "military_units", force: :cascade do |t|
    t.string "military_unit_type", null: false
    t.integer "military_unit_power", null: false
    t.string "stance", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "move_armies", force: :cascade do |t|
    t.bigint "player_id", null: false
    t.bigint "player_action_id", null: false
    t.bigint "military_unit_id", null: false
    t.string "stance_command", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["military_unit_id"], name: "index_move_armies_on_military_unit_id"
    t.index ["player_action_id"], name: "index_move_armies_on_player_action_id"
    t.index ["player_id"], name: "index_move_armies_on_player_id"
  end

  create_table "path_to_power_constructions", force: :cascade do |t|
    t.bigint "construction_id", null: false
    t.string "path_to_power_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["construction_id"], name: "index_path_to_power_constructions_on_construction_id"
  end

  create_table "player_actions", force: :cascade do |t|
    t.bigint "player_id", null: false
    t.bigint "round_id", null: false
    t.string "action_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["player_id"], name: "index_player_actions_on_player_id"
    t.index ["round_id"], name: "index_player_actions_on_round_id"
  end

  create_table "player_loyalties", force: :cascade do |t|
    t.integer "player_loyalty_quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "player_loyalty_roles", force: :cascade do |t|
    t.bigint "player_id", null: false
    t.bigint "player_loyalty_id", null: false
    t.string "player_loyalty_role_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["player_id"], name: "index_player_loyalty_roles_on_player_id"
    t.index ["player_loyalty_id"], name: "index_player_loyalty_roles_on_player_loyalty_id"
  end

  create_table "player_match_roles", force: :cascade do |t|
    t.bigint "match_id", null: false
    t.bigint "player_id", null: false
    t.string "player_match_role_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["match_id"], name: "index_player_match_roles_on_match_id"
    t.index ["player_id"], name: "index_player_match_roles_on_player_id"
  end

  create_table "player_military_unit_roles", force: :cascade do |t|
    t.bigint "player_id", null: false
    t.bigint "military_unit_id", null: false
    t.string "military_unit_role_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["military_unit_id"], name: "index_player_military_unit_roles_on_military_unit_id"
    t.index ["player_id"], name: "index_player_military_unit_roles_on_player_id"
  end

  create_table "player_resources", force: :cascade do |t|
    t.bigint "player_id", null: false
    t.integer "resource_quantity"
    t.string "resource_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["player_id"], name: "index_player_resources_on_player_id"
  end

  create_table "players", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "game_id", null: false
    t.string "house_name"
    t.integer "victory_points", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_players_on_game_id"
    t.index ["user_id"], name: "index_players_on_user_id"
  end

  create_table "raise_armies", force: :cascade do |t|
    t.integer "army_power"
    t.string "raise_army_type", null: false
    t.bigint "player_action_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["player_action_id"], name: "index_raise_armies_on_player_action_id"
  end

  create_table "resource_generator_constructions", force: :cascade do |t|
    t.bigint "construction_id", null: false
    t.string "resource_generator_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["construction_id"], name: "index_resource_generator_constructions_on_construction_id"
  end

  create_table "resource_generators", force: :cascade do |t|
    t.bigint "player_id", null: false
    t.string "resource_generator_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["player_id"], name: "index_resource_generators_on_player_id"
  end

  create_table "rounds", force: :cascade do |t|
    t.bigint "match_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["match_id"], name: "index_rounds_on_match_id"
  end

  create_table "trade_player_roles", force: :cascade do |t|
    t.bigint "player_id", null: false
    t.bigint "trade_request_id", null: false
    t.string "role_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["player_id"], name: "index_trade_player_roles_on_player_id"
    t.index ["trade_request_id"], name: "index_trade_player_roles_on_trade_request_id"
  end

  create_table "trade_request_resources", force: :cascade do |t|
    t.bigint "trade_request_id", null: false
    t.string "trade_request_resource_type"
    t.integer "trade_request_resource_quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["trade_request_id"], name: "index_trade_request_resources_on_trade_request_id"
  end

  create_table "trade_request_responses", force: :cascade do |t|
    t.bigint "trade_player_role_id", null: false
    t.bigint "trade_request_id", null: false
    t.string "trade_response_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["trade_player_role_id"], name: "index_trade_request_responses_on_trade_player_role_id"
    t.index ["trade_request_id"], name: "index_trade_request_responses_on_trade_request_id"
  end

  create_table "trade_requests", force: :cascade do |t|
    t.bigint "round_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["round_id"], name: "index_trade_requests_on_round_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "user_email", null: false
    t.string "password_digest", null: false
    t.string "email_confirmation_token", default: ""
    t.boolean "email_confirmed", default: true
    t.boolean "is_admin", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "constructions", "players"
  add_foreign_key "constructions", "rounds"
  add_foreign_key "fund_request_responses", "funding_request_player_roles"
  add_foreign_key "fund_request_responses", "funding_requests"
  add_foreign_key "funding_request_player_roles", "funding_requests"
  add_foreign_key "funding_request_player_roles", "players"
  add_foreign_key "funding_request_resources", "funding_requests"
  add_foreign_key "funding_requests", "constructions"
  add_foreign_key "funding_requests", "rounds"
  add_foreign_key "fundings", "constructions"
  add_foreign_key "gather_informations", "player_actions"
  add_foreign_key "gather_informations", "players"
  add_foreign_key "matches", "games"
  add_foreign_key "move_armies", "military_units"
  add_foreign_key "move_armies", "player_actions"
  add_foreign_key "move_armies", "players"
  add_foreign_key "path_to_power_constructions", "constructions"
  add_foreign_key "player_actions", "players"
  add_foreign_key "player_actions", "rounds"
  add_foreign_key "player_loyalty_roles", "player_loyalties"
  add_foreign_key "player_loyalty_roles", "players"
  add_foreign_key "player_match_roles", "matches"
  add_foreign_key "player_match_roles", "players"
  add_foreign_key "player_military_unit_roles", "military_units"
  add_foreign_key "player_military_unit_roles", "players"
  add_foreign_key "player_resources", "players"
  add_foreign_key "players", "games"
  add_foreign_key "players", "users"
  add_foreign_key "raise_armies", "player_actions"
  add_foreign_key "resource_generator_constructions", "constructions"
  add_foreign_key "resource_generators", "players"
  add_foreign_key "rounds", "matches"
  add_foreign_key "trade_player_roles", "players"
  add_foreign_key "trade_player_roles", "trade_requests"
  add_foreign_key "trade_request_resources", "trade_requests"
  add_foreign_key "trade_request_responses", "trade_player_roles"
  add_foreign_key "trade_request_responses", "trade_requests"
  add_foreign_key "trade_requests", "rounds"
end
