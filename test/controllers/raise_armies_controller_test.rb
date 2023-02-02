require "test_helper"

class RaiseArmiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @raise_army = raise_armies(:one)
  end

  test "should get index" do
    get raise_armies_url
    assert_response :success
  end

  test "should get new" do
    get new_raise_army_url
    assert_response :success
  end

  test "should create raise_army" do
    assert_difference("RaiseArmy.count") do
      post raise_armies_url, params: { raise_army: { army_power: @raise_army.army_power, player_action_id: @raise_army.player_action_id } }
    end

    assert_redirected_to raise_army_url(RaiseArmy.last)
  end

  test "should show raise_army" do
    get raise_army_url(@raise_army)
    assert_response :success
  end

  test "should get edit" do
    get edit_raise_army_url(@raise_army)
    assert_response :success
  end

  test "should update raise_army" do
    patch raise_army_url(@raise_army), params: { raise_army: { army_power: @raise_army.army_power, player_action_id: @raise_army.player_action_id } }
    assert_redirected_to raise_army_url(@raise_army)
  end

  test "should destroy raise_army" do
    assert_difference("RaiseArmy.count", -1) do
      delete raise_army_url(@raise_army)
    end

    assert_redirected_to raise_armies_url
  end
end
