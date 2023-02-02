require "test_helper"

class MoveArmiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @move_army = move_armies(:one)
  end

  test "should get index" do
    get move_armies_url
    assert_response :success
  end

  test "should get new" do
    get new_move_army_url
    assert_response :success
  end

  test "should create move_army" do
    assert_difference("MoveArmy.count") do
      post move_armies_url, params: { move_army: { military_unit_id: @move_army.military_unit_id, player_action_id: @move_army.player_action_id, player_id: @move_army.player_id } }
    end

    assert_redirected_to move_army_url(MoveArmy.last)
  end

  test "should show move_army" do
    get move_army_url(@move_army)
    assert_response :success
  end

  test "should get edit" do
    get edit_move_army_url(@move_army)
    assert_response :success
  end

  test "should update move_army" do
    patch move_army_url(@move_army), params: { move_army: { military_unit_id: @move_army.military_unit_id, player_action_id: @move_army.player_action_id, player_id: @move_army.player_id } }
    assert_redirected_to move_army_url(@move_army)
  end

  test "should destroy move_army" do
    assert_difference("MoveArmy.count", -1) do
      delete move_army_url(@move_army)
    end

    assert_redirected_to move_armies_url
  end
end
