require "test_helper"

class PathToPowerConstructionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @path_to_power_construction = path_to_power_constructions(:one)
  end

  test "should get index" do
    get path_to_power_constructions_url
    assert_response :success
  end

  test "should get new" do
    get new_path_to_power_construction_url
    assert_response :success
  end

  test "should create path_to_power_construction" do
    assert_difference("PathToPowerConstruction.count") do
      post path_to_power_constructions_url, params: { path_to_power_construction: { construction_id: @path_to_power_construction.construction_id, path_to_power_type: @path_to_power_construction.path_to_power_type } }
    end

    assert_redirected_to path_to_power_construction_url(PathToPowerConstruction.last)
  end

  test "should show path_to_power_construction" do
    get path_to_power_construction_url(@path_to_power_construction)
    assert_response :success
  end

  test "should get edit" do
    get edit_path_to_power_construction_url(@path_to_power_construction)
    assert_response :success
  end

  test "should update path_to_power_construction" do
    patch path_to_power_construction_url(@path_to_power_construction), params: { path_to_power_construction: { construction_id: @path_to_power_construction.construction_id, path_to_power_type: @path_to_power_construction.path_to_power_type } }
    assert_redirected_to path_to_power_construction_url(@path_to_power_construction)
  end

  test "should destroy path_to_power_construction" do
    assert_difference("PathToPowerConstruction.count", -1) do
      delete path_to_power_construction_url(@path_to_power_construction)
    end

    assert_redirected_to path_to_power_constructions_url
  end
end
