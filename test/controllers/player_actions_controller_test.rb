require "test_helper"

class PlayerActionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @player_action = player_actions(:one)
  end

  test "should get index" do
    get player_actions_url
    assert_response :success
  end

  test "should get new" do
    get new_player_action_url
    assert_response :success
  end

  test "should create player_action" do
    assert_difference("PlayerAction.count") do
      post player_actions_url, params: { player_action: { action_type: @player_action.action_type, player_id: @player_action.player_id, round_id: @player_action.round_id } }
    end

    assert_redirected_to player_action_url(PlayerAction.last)
  end

  test "should show player_action" do
    get player_action_url(@player_action)
    assert_response :success
  end

  test "should get edit" do
    get edit_player_action_url(@player_action)
    assert_response :success
  end

  test "should update player_action" do
    patch player_action_url(@player_action), params: { player_action: { action_type: @player_action.action_type, player_id: @player_action.player_id, round_id: @player_action.round_id } }
    assert_redirected_to player_action_url(@player_action)
  end

  test "should destroy player_action" do
    assert_difference("PlayerAction.count", -1) do
      delete player_action_url(@player_action)
    end

    assert_redirected_to player_actions_url
  end
end
