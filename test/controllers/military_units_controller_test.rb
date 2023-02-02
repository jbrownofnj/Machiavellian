require "test_helper"

class MilitaryUnitsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @military_unit = military_units(:one)
  end

  test "should get index" do
    get military_units_url
    assert_response :success
  end

  test "should get new" do
    get new_military_unit_url
    assert_response :success
  end

  test "should create military_unit" do
    assert_difference("MilitaryUnit.count") do
      post military_units_url, params: { military_unit: { military_unit_power: @military_unit.military_unit_power, military_unit_type: @military_unit.military_unit_type } }
    end

    assert_redirected_to military_unit_url(MilitaryUnit.last)
  end

  test "should show military_unit" do
    get military_unit_url(@military_unit)
    assert_response :success
  end

  test "should get edit" do
    get edit_military_unit_url(@military_unit)
    assert_response :success
  end

  test "should update military_unit" do
    patch military_unit_url(@military_unit), params: { military_unit: { military_unit_power: @military_unit.military_unit_power, military_unit_type: @military_unit.military_unit_type } }
    assert_redirected_to military_unit_url(@military_unit)
  end

  test "should destroy military_unit" do
    assert_difference("MilitaryUnit.count", -1) do
      delete military_unit_url(@military_unit)
    end

    assert_redirected_to military_units_url
  end
end
