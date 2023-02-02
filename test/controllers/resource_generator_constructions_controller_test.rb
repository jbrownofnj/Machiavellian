require "test_helper"

class ResourceGeneratorConstructionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @resource_generator_construction = resource_generator_constructions(:one)
  end

  test "should get index" do
    get resource_generator_constructions_url
    assert_response :success
  end

  test "should get new" do
    get new_resource_generator_construction_url
    assert_response :success
  end

  test "should create resource_generator_construction" do
    assert_difference("ResourceGeneratorConstruction.count") do
      post resource_generator_constructions_url, params: { resource_generator_construction: { construction_id: @resource_generator_construction.construction_id, resource_generator_type: @resource_generator_construction.resource_generator_type } }
    end

    assert_redirected_to resource_generator_construction_url(ResourceGeneratorConstruction.last)
  end

  test "should show resource_generator_construction" do
    get resource_generator_construction_url(@resource_generator_construction)
    assert_response :success
  end

  test "should get edit" do
    get edit_resource_generator_construction_url(@resource_generator_construction)
    assert_response :success
  end

  test "should update resource_generator_construction" do
    patch resource_generator_construction_url(@resource_generator_construction), params: { resource_generator_construction: { construction_id: @resource_generator_construction.construction_id, resource_generator_type: @resource_generator_construction.resource_generator_type } }
    assert_redirected_to resource_generator_construction_url(@resource_generator_construction)
  end

  test "should destroy resource_generator_construction" do
    assert_difference("ResourceGeneratorConstruction.count", -1) do
      delete resource_generator_construction_url(@resource_generator_construction)
    end

    assert_redirected_to resource_generator_constructions_url
  end
end
