require "test_helper"

class PlayerResourcesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @player_resource = player_resources(:one)
  end

  test "should get index" do
    get player_resources_url
    assert_response :success
  end

  test "should get new" do
    get new_player_resource_url
    assert_response :success
  end

  test "should create player_resource" do
    assert_difference("PlayerResource.count") do
      post player_resources_url, params: { player_resource: { player_id: @player_resource.player_id, resource_quantity: @player_resource.resource_quantity, resource_type: @player_resource.resource_type } }
    end

    assert_redirected_to player_resource_url(PlayerResource.last)
  end

  test "should show player_resource" do
    get player_resource_url(@player_resource)
    assert_response :success
  end

  test "should get edit" do
    get edit_player_resource_url(@player_resource)
    assert_response :success
  end

  test "should update player_resource" do
    patch player_resource_url(@player_resource), params: { player_resource: { player_id: @player_resource.player_id, resource_quantity: @player_resource.resource_quantity, resource_type: @player_resource.resource_type } }
    assert_redirected_to player_resource_url(@player_resource)
  end

  test "should destroy player_resource" do
    assert_difference("PlayerResource.count", -1) do
      delete player_resource_url(@player_resource)
    end

    assert_redirected_to player_resources_url
  end
end
