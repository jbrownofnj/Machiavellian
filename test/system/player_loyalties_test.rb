require "application_system_test_case"

class PlayerLoyaltiesTest < ApplicationSystemTestCase
  setup do
    @player_loyalty = player_loyalties(:one)
  end

  test "visiting the index" do
    visit player_loyalties_url
    assert_selector "h1", text: "Player loyalties"
  end

  test "should create player loyalty" do
    visit player_loyalties_url
    click_on "New player loyalty"

    fill_in "Player loyalty quantity", with: @player_loyalty.player_loyalty_quantity
    click_on "Create Player loyalty"

    assert_text "Player loyalty was successfully created"
    click_on "Back"
  end

  test "should update Player loyalty" do
    visit player_loyalty_url(@player_loyalty)
    click_on "Edit this player loyalty", match: :first

    fill_in "Player loyalty quantity", with: @player_loyalty.player_loyalty_quantity
    click_on "Update Player loyalty"

    assert_text "Player loyalty was successfully updated"
    click_on "Back"
  end

  test "should destroy Player loyalty" do
    visit player_loyalty_url(@player_loyalty)
    click_on "Destroy this player loyalty", match: :first

    assert_text "Player loyalty was successfully destroyed"
  end
end
