require "application_system_test_case"

class PlayerMilitaryUnitRolesTest < ApplicationSystemTestCase
  setup do
    @player_military_unit_role = player_military_unit_roles(:one)
  end

  test "visiting the index" do
    visit player_military_unit_roles_url
    assert_selector "h1", text: "Player military unit roles"
  end

  test "should create player military unit role" do
    visit player_military_unit_roles_url
    click_on "New player military unit role"

    fill_in "Military unit", with: @player_military_unit_role.military_unit_id
    fill_in "Military unit role type", with: @player_military_unit_role.military_unit_role_type
    fill_in "Player", with: @player_military_unit_role.player_id
    click_on "Create Player military unit role"

    assert_text "Player military unit role was successfully created"
    click_on "Back"
  end

  test "should update Player military unit role" do
    visit player_military_unit_role_url(@player_military_unit_role)
    click_on "Edit this player military unit role", match: :first

    fill_in "Military unit", with: @player_military_unit_role.military_unit_id
    fill_in "Military unit role type", with: @player_military_unit_role.military_unit_role_type
    fill_in "Player", with: @player_military_unit_role.player_id
    click_on "Update Player military unit role"

    assert_text "Player military unit role was successfully updated"
    click_on "Back"
  end

  test "should destroy Player military unit role" do
    visit player_military_unit_role_url(@player_military_unit_role)
    click_on "Destroy this player military unit role", match: :first

    assert_text "Player military unit role was successfully destroyed"
  end
end
