require "application_system_test_case"

class RaiseArmiesTest < ApplicationSystemTestCase
  setup do
    @raise_army = raise_armies(:one)
  end

  test "visiting the index" do
    visit raise_armies_url
    assert_selector "h1", text: "Raise armies"
  end

  test "should create raise army" do
    visit raise_armies_url
    click_on "New raise army"

    fill_in "Army power", with: @raise_army.army_power
    fill_in "Player action", with: @raise_army.player_action_id
    click_on "Create Raise army"

    assert_text "Raise army was successfully created"
    click_on "Back"
  end

  test "should update Raise army" do
    visit raise_army_url(@raise_army)
    click_on "Edit this raise army", match: :first

    fill_in "Army power", with: @raise_army.army_power
    fill_in "Player action", with: @raise_army.player_action_id
    click_on "Update Raise army"

    assert_text "Raise army was successfully updated"
    click_on "Back"
  end

  test "should destroy Raise army" do
    visit raise_army_url(@raise_army)
    click_on "Destroy this raise army", match: :first

    assert_text "Raise army was successfully destroyed"
  end
end
