require "application_system_test_case"

class ConstructionsTest < ApplicationSystemTestCase
  setup do
    @construction = constructions(:one)
  end

  test "visiting the index" do
    visit constructions_url
    assert_selector "h1", text: "Constructions"
  end

  test "should create construction" do
    visit constructions_url
    click_on "New construction"

    fill_in "Construction type", with: @construction.construction_type
    fill_in "Player", with: @construction.player_id
    click_on "Create Construction"

    assert_text "Construction was successfully created"
    click_on "Back"
  end

  test "should update Construction" do
    visit construction_url(@construction)
    click_on "Edit this construction", match: :first

    fill_in "Construction type", with: @construction.construction_type
    fill_in "Player", with: @construction.player_id
    click_on "Update Construction"

    assert_text "Construction was successfully updated"
    click_on "Back"
  end

  test "should destroy Construction" do
    visit construction_url(@construction)
    click_on "Destroy this construction", match: :first

    assert_text "Construction was successfully destroyed"
  end
end
