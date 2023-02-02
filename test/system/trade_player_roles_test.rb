require "application_system_test_case"

class TradePlayerRolesTest < ApplicationSystemTestCase
  setup do
    @trade_player_role = trade_player_roles(:one)
  end

  test "visiting the index" do
    visit trade_player_roles_url
    assert_selector "h1", text: "Trade player roles"
  end

  test "should create trade player role" do
    visit trade_player_roles_url
    click_on "New trade player role"

    fill_in "Player", with: @trade_player_role.player_id
    fill_in "Role type", with: @trade_player_role.role_type
    fill_in "Trade request resource", with: @trade_player_role.trade_request_resource_id
    click_on "Create Trade player role"

    assert_text "Trade player role was successfully created"
    click_on "Back"
  end

  test "should update Trade player role" do
    visit trade_player_role_url(@trade_player_role)
    click_on "Edit this trade player role", match: :first

    fill_in "Player", with: @trade_player_role.player_id
    fill_in "Role type", with: @trade_player_role.role_type
    fill_in "Trade request resource", with: @trade_player_role.trade_request_resource_id
    click_on "Update Trade player role"

    assert_text "Trade player role was successfully updated"
    click_on "Back"
  end

  test "should destroy Trade player role" do
    visit trade_player_role_url(@trade_player_role)
    click_on "Destroy this trade player role", match: :first

    assert_text "Trade player role was successfully destroyed"
  end
end
