require "application_system_test_case"

class MilitaryUnitsTest < ApplicationSystemTestCase
  setup do
    @military_unit = military_units(:one)
  end

  test "visiting the index" do
    visit military_units_url
    assert_selector "h1", text: "Military units"
  end

  test "should create military unit" do
    visit military_units_url
    click_on "New military unit"

    fill_in "Military unit power", with: @military_unit.military_unit_power
    fill_in "Military unit type", with: @military_unit.military_unit_type
    click_on "Create Military unit"

    assert_text "Military unit was successfully created"
    click_on "Back"
  end

  test "should update Military unit" do
    visit military_unit_url(@military_unit)
    click_on "Edit this military unit", match: :first

    fill_in "Military unit power", with: @military_unit.military_unit_power
    fill_in "Military unit type", with: @military_unit.military_unit_type
    click_on "Update Military unit"

    assert_text "Military unit was successfully updated"
    click_on "Back"
  end

  test "should destroy Military unit" do
    visit military_unit_url(@military_unit)
    click_on "Destroy this military unit", match: :first

    assert_text "Military unit was successfully destroyed"
  end
end
