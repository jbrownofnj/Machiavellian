require "application_system_test_case"

class FundingRequestPlayerRolesTest < ApplicationSystemTestCase
  setup do
    @funding_request_player_role = funding_request_player_roles(:one)
  end

  test "visiting the index" do
    visit funding_request_player_roles_url
    assert_selector "h1", text: "Funding request player roles"
  end

  test "should create funding request player role" do
    visit funding_request_player_roles_url
    click_on "New funding request player role"

    fill_in "Funding request", with: @funding_request_player_role.funding_request_id
    fill_in "Player", with: @funding_request_player_role.player_id
    fill_in "Player role", with: @funding_request_player_role.player_role
    click_on "Create Funding request player role"

    assert_text "Funding request player role was successfully created"
    click_on "Back"
  end

  test "should update Funding request player role" do
    visit funding_request_player_role_url(@funding_request_player_role)
    click_on "Edit this funding request player role", match: :first

    fill_in "Funding request", with: @funding_request_player_role.funding_request_id
    fill_in "Player", with: @funding_request_player_role.player_id
    fill_in "Player role", with: @funding_request_player_role.player_role
    click_on "Update Funding request player role"

    assert_text "Funding request player role was successfully updated"
    click_on "Back"
  end

  test "should destroy Funding request player role" do
    visit funding_request_player_role_url(@funding_request_player_role)
    click_on "Destroy this funding request player role", match: :first

    assert_text "Funding request player role was successfully destroyed"
  end
end
