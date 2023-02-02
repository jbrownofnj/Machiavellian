require "test_helper"

class PlayerLoyaltyRolesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @player_loyalty_role = player_loyalty_roles(:one)
  end

  test "should get index" do
    get player_loyalty_roles_url
    assert_response :success
  end

  test "should get new" do
    get new_player_loyalty_role_url
    assert_response :success
  end

  test "should create player_loyalty_role" do
    assert_difference("PlayerLoyaltyRole.count") do
      post player_loyalty_roles_url, params: { player_loyalty_role: { player_id: @player_loyalty_role.player_id, player_loyalty_id: @player_loyalty_role.player_loyalty_id, player_loyalty_role_type: @player_loyalty_role.player_loyalty_role_type } }
    end

    assert_redirected_to player_loyalty_role_url(PlayerLoyaltyRole.last)
  end

  test "should show player_loyalty_role" do
    get player_loyalty_role_url(@player_loyalty_role)
    assert_response :success
  end

  test "should get edit" do
    get edit_player_loyalty_role_url(@player_loyalty_role)
    assert_response :success
  end

  test "should update player_loyalty_role" do
    patch player_loyalty_role_url(@player_loyalty_role), params: { player_loyalty_role: { player_id: @player_loyalty_role.player_id, player_loyalty_id: @player_loyalty_role.player_loyalty_id, player_loyalty_role_type: @player_loyalty_role.player_loyalty_role_type } }
    assert_redirected_to player_loyalty_role_url(@player_loyalty_role)
  end

  test "should destroy player_loyalty_role" do
    assert_difference("PlayerLoyaltyRole.count", -1) do
      delete player_loyalty_role_url(@player_loyalty_role)
    end

    assert_redirected_to player_loyalty_roles_url
  end
end
