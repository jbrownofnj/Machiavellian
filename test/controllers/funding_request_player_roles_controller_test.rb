require "test_helper"

class FundingRequestPlayerRolesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @funding_request_player_role = funding_request_player_roles(:one)
  end

  test "should get index" do
    get funding_request_player_roles_url
    assert_response :success
  end

  test "should get new" do
    get new_funding_request_player_role_url
    assert_response :success
  end

  test "should create funding_request_player_role" do
    assert_difference("FundingRequestPlayerRole.count") do
      post funding_request_player_roles_url, params: { funding_request_player_role: { funding_request_id: @funding_request_player_role.funding_request_id, player_id: @funding_request_player_role.player_id, player_role: @funding_request_player_role.player_role } }
    end

    assert_redirected_to funding_request_player_role_url(FundingRequestPlayerRole.last)
  end

  test "should show funding_request_player_role" do
    get funding_request_player_role_url(@funding_request_player_role)
    assert_response :success
  end

  test "should get edit" do
    get edit_funding_request_player_role_url(@funding_request_player_role)
    assert_response :success
  end

  test "should update funding_request_player_role" do
    patch funding_request_player_role_url(@funding_request_player_role), params: { funding_request_player_role: { funding_request_id: @funding_request_player_role.funding_request_id, player_id: @funding_request_player_role.player_id, player_role: @funding_request_player_role.player_role } }
    assert_redirected_to funding_request_player_role_url(@funding_request_player_role)
  end

  test "should destroy funding_request_player_role" do
    assert_difference("FundingRequestPlayerRole.count", -1) do
      delete funding_request_player_role_url(@funding_request_player_role)
    end

    assert_redirected_to funding_request_player_roles_url
  end
end
