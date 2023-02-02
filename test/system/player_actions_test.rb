require "application_system_test_case"

class PlayerActionsTest < ApplicationSystemTestCase
  setup do
    @player_action = player_actions(:one)
  end

  test "visiting the index" do
    visit player_actions_url
    assert_selector "h1", text: "Player actions"
  end

  test "should create player action" do
    visit player_actions_url
    click_on "New player action"

    fill_in "Action type", with: @player_action.action_type
    fill_in "Player", with: @player_action.player_id
    fill_in "Round", with: @player_action.round_id
    click_on "Create Player action"

    assert_text "Player action was successfully created"
    click_on "Back"
  end

  test "should update Player action" do
    visit player_action_url(@player_action)
    click_on "Edit this player action", match: :first

    fill_in "Action type", with: @player_action.action_type
    fill_in "Player", with: @player_action.player_id
    fill_in "Round", with: @player_action.round_id
    click_on "Update Player action"

    assert_text "Player action was successfully updated"
    click_on "Back"
  end

  test "should destroy Player action" do
    visit player_action_url(@player_action)
    click_on "Destroy this player action", match: :first

    assert_text "Player action was successfully destroyed"
  end
end
