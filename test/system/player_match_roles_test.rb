require "application_system_test_case"

class PlayerMatchRolesTest < ApplicationSystemTestCase
  setup do
    @player_match_role = player_match_roles(:one)
  end

  test "visiting the index" do
    visit player_match_roles_url
    assert_selector "h1", text: "Player match roles"
  end

  test "should create player match role" do
    visit player_match_roles_url
    click_on "New player match role"

    fill_in "Match", with: @player_match_role.match_id
    fill_in "Player", with: @player_match_role.player_id
    fill_in "Player match role type", with: @player_match_role.player_match_role_type
    click_on "Create Player match role"

    assert_text "Player match role was successfully created"
    click_on "Back"
  end

  test "should update Player match role" do
    visit player_match_role_url(@player_match_role)
    click_on "Edit this player match role", match: :first

    fill_in "Match", with: @player_match_role.match_id
    fill_in "Player", with: @player_match_role.player_id
    fill_in "Player match role type", with: @player_match_role.player_match_role_type
    click_on "Update Player match role"

    assert_text "Player match role was successfully updated"
    click_on "Back"
  end

  test "should destroy Player match role" do
    visit player_match_role_url(@player_match_role)
    click_on "Destroy this player match role", match: :first

    assert_text "Player match role was successfully destroyed"
  end
end
