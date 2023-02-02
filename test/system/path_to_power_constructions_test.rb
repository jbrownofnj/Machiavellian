require "application_system_test_case"

class PathToPowerConstructionsTest < ApplicationSystemTestCase
  setup do
    @path_to_power_construction = path_to_power_constructions(:one)
  end

  test "visiting the index" do
    visit path_to_power_constructions_url
    assert_selector "h1", text: "Path to power constructions"
  end

  test "should create path to power construction" do
    visit path_to_power_constructions_url
    click_on "New path to power construction"

    fill_in "Construction", with: @path_to_power_construction.construction_id
    fill_in "Path to power type", with: @path_to_power_construction.path_to_power_type
    click_on "Create Path to power construction"

    assert_text "Path to power construction was successfully created"
    click_on "Back"
  end

  test "should update Path to power construction" do
    visit path_to_power_construction_url(@path_to_power_construction)
    click_on "Edit this path to power construction", match: :first

    fill_in "Construction", with: @path_to_power_construction.construction_id
    fill_in "Path to power type", with: @path_to_power_construction.path_to_power_type
    click_on "Update Path to power construction"

    assert_text "Path to power construction was successfully updated"
    click_on "Back"
  end

  test "should destroy Path to power construction" do
    visit path_to_power_construction_url(@path_to_power_construction)
    click_on "Destroy this path to power construction", match: :first

    assert_text "Path to power construction was successfully destroyed"
  end
end
