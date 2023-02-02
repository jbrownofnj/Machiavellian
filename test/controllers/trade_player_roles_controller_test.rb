require "test_helper"

class TradePlayerRolesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @trade_player_role = trade_player_roles(:one)
  end

  test "should get index" do
    get trade_player_roles_url
    assert_response :success
  end

  test "should get new" do
    get new_trade_player_role_url
    assert_response :success
  end

  test "should create trade_player_role" do
    assert_difference("TradePlayerRole.count") do
      post trade_player_roles_url, params: { trade_player_role: { player_id: @trade_player_role.player_id, role_type: @trade_player_role.role_type, trade_request_resource_id: @trade_player_role.trade_request_resource_id } }
    end

    assert_redirected_to trade_player_role_url(TradePlayerRole.last)
  end

  test "should show trade_player_role" do
    get trade_player_role_url(@trade_player_role)
    assert_response :success
  end

  test "should get edit" do
    get edit_trade_player_role_url(@trade_player_role)
    assert_response :success
  end

  test "should update trade_player_role" do
    patch trade_player_role_url(@trade_player_role), params: { trade_player_role: { player_id: @trade_player_role.player_id, role_type: @trade_player_role.role_type, trade_request_resource_id: @trade_player_role.trade_request_resource_id } }
    assert_redirected_to trade_player_role_url(@trade_player_role)
  end

  test "should destroy trade_player_role" do
    assert_difference("TradePlayerRole.count", -1) do
      delete trade_player_role_url(@trade_player_role)
    end

    assert_redirected_to trade_player_roles_url
  end
end
