require "application_system_test_case"

class PlayerLoyaltyRolesTest < ApplicationSystemTestCase
  setup do
    @player_loyalty_role = player_loyalty_roles(:one)
  end

  test "visiting the index" do
    visit player_loyalty_roles_url
    assert_selector "h1", text: "Player loyalty roles"
  end

  test "should create player loyalty role" do
    visit player_loyalty_roles_url
    click_on "New player loyalty role"

    fill_in "Player", with: @player_loyalty_role.player_id
    fill_in "Player loyalty", with: @player_loyalty_role.player_loyalty_id
    fill_in "Player loyalty role type", with: @player_loyalty_role.player_loyalty_role_type
    click_on "Create Player loyalty role"

    assert_text "Player loyalty role was successfully created"
    click_on "Back"
  end

  test "should update Player loyalty role" do
    visit player_loyalty_role_url(@player_loyalty_role)
    click_on "Edit this player loyalty role", match: :first

    fill_in "Player", with: @player_loyalty_role.player_id
    fill_in "Player loyalty", with: @player_loyalty_role.player_loyalty_id
    fill_in "Player loyalty role type", with: @player_loyalty_role.player_loyalty_role_type
    click_on "Update Player loyalty role"

    assert_text "Player loyalty role was successfully updated"
    click_on "Back"
  end

  test "should destroy Player loyalty role" do
    visit player_loyalty_role_url(@player_loyalty_role)
    click_on "Destroy this player loyalty role", match: :first

    assert_text "Player loyalty role was successfully destroyed"
  end
end
