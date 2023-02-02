require "test_helper"

class PlayerMatchRolesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @player_match_role = player_match_roles(:one)
  end

  test "should get index" do
    get player_match_roles_url
    assert_response :success
  end

  test "should get new" do
    get new_player_match_role_url
    assert_response :success
  end

  test "should create player_match_role" do
    assert_difference("PlayerMatchRole.count") do
      post player_match_roles_url, params: { player_match_role: { match_id: @player_match_role.match_id, player_id: @player_match_role.player_id, player_match_role_type: @player_match_role.player_match_role_type } }
    end

    assert_redirected_to player_match_role_url(PlayerMatchRole.last)
  end

  test "should show player_match_role" do
    get player_match_role_url(@player_match_role)
    assert_response :success
  end

  test "should get edit" do
    get edit_player_match_role_url(@player_match_role)
    assert_response :success
  end

  test "should update player_match_role" do
    patch player_match_role_url(@player_match_role), params: { player_match_role: { match_id: @player_match_role.match_id, player_id: @player_match_role.player_id, player_match_role_type: @player_match_role.player_match_role_type } }
    assert_redirected_to player_match_role_url(@player_match_role)
  end

  test "should destroy player_match_role" do
    assert_difference("PlayerMatchRole.count", -1) do
      delete player_match_role_url(@player_match_role)
    end

    assert_redirected_to player_match_roles_url
  end
end
