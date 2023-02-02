require "test_helper"

class ResourceGeneratorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @resource_generator = resource_generators(:one)
  end

  test "should get index" do
    get resource_generators_url
    assert_response :success
  end

  test "should get new" do
    get new_resource_generator_url
    assert_response :success
  end

  test "should create resource_generator" do
    assert_difference("ResourceGenerator.count") do
      post resource_generators_url, params: { resource_generator: { player_id: @resource_generator.player_id, resource_generator_type: @resource_generator.resource_generator_type } }
    end

    assert_redirected_to resource_generator_url(ResourceGenerator.last)
  end

  test "should show resource_generator" do
    get resource_generator_url(@resource_generator)
    assert_response :success
  end

  test "should get edit" do
    get edit_resource_generator_url(@resource_generator)
    assert_response :success
  end

  test "should update resource_generator" do
    patch resource_generator_url(@resource_generator), params: { resource_generator: { player_id: @resource_generator.player_id, resource_generator_type: @resource_generator.resource_generator_type } }
    assert_redirected_to resource_generator_url(@resource_generator)
  end

  test "should destroy resource_generator" do
    assert_difference("ResourceGenerator.count", -1) do
      delete resource_generator_url(@resource_generator)
    end

    assert_redirected_to resource_generators_url
  end
end
