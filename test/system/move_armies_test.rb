require "application_system_test_case"

class MoveArmiesTest < ApplicationSystemTestCase
  setup do
    @move_army = move_armies(:one)
  end

  test "visiting the index" do
    visit move_armies_url
    assert_selector "h1", text: "Move armies"
  end

  test "should create move army" do
    visit move_armies_url
    click_on "New move army"

    fill_in "Military unit", with: @move_army.military_unit_id
    fill_in "Player action", with: @move_army.player_action_id
    fill_in "Player", with: @move_army.player_id
    click_on "Create Move army"

    assert_text "Move army was successfully created"
    click_on "Back"
  end

  test "should update Move army" do
    visit move_army_url(@move_army)
    click_on "Edit this move army", match: :first

    fill_in "Military unit", with: @move_army.military_unit_id
    fill_in "Player action", with: @move_army.player_action_id
    fill_in "Player", with: @move_army.player_id
    click_on "Update Move army"

    assert_text "Move army was successfully updated"
    click_on "Back"
  end

  test "should destroy Move army" do
    visit move_army_url(@move_army)
    click_on "Destroy this move army", match: :first

    assert_text "Move army was successfully destroyed"
  end
end
