require "test_helper"

class PlayerMilitaryUnitRolesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @player_military_unit_role = player_military_unit_roles(:one)
  end

  test "should get index" do
    get player_military_unit_roles_url
    assert_response :success
  end

  test "should get new" do
    get new_player_military_unit_role_url
    assert_response :success
  end

  test "should create player_military_unit_role" do
    assert_difference("PlayerMilitaryUnitRole.count") do
      post player_military_unit_roles_url, params: { player_military_unit_role: { military_unit_id: @player_military_unit_role.military_unit_id, military_unit_role_type: @player_military_unit_role.military_unit_role_type, player_id: @player_military_unit_role.player_id } }
    end

    assert_redirected_to player_military_unit_role_url(PlayerMilitaryUnitRole.last)
  end

  test "should show player_military_unit_role" do
    get player_military_unit_role_url(@player_military_unit_role)
    assert_response :success
  end

  test "should get edit" do
    get edit_player_military_unit_role_url(@player_military_unit_role)
    assert_response :success
  end

  test "should update player_military_unit_role" do
    patch player_military_unit_role_url(@player_military_unit_role), params: { player_military_unit_role: { military_unit_id: @player_military_unit_role.military_unit_id, military_unit_role_type: @player_military_unit_role.military_unit_role_type, player_id: @player_military_unit_role.player_id } }
    assert_redirected_to player_military_unit_role_url(@player_military_unit_role)
  end

  test "should destroy player_military_unit_role" do
    assert_difference("PlayerMilitaryUnitRole.count", -1) do
      delete player_military_unit_role_url(@player_military_unit_role)
    end

    assert_redirected_to player_military_unit_roles_url
  end
end
