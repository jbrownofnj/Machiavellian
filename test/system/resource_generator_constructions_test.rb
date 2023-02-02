require "application_system_test_case"

class ResourceGeneratorConstructionsTest < ApplicationSystemTestCase
  setup do
    @resource_generator_construction = resource_generator_constructions(:one)
  end

  test "visiting the index" do
    visit resource_generator_constructions_url
    assert_selector "h1", text: "Resource generator constructions"
  end

  test "should create resource generator construction" do
    visit resource_generator_constructions_url
    click_on "New resource generator construction"

    fill_in "Construction", with: @resource_generator_construction.construction_id
    fill_in "Resource generator type", with: @resource_generator_construction.resource_generator_type
    click_on "Create Resource generator construction"

    assert_text "Resource generator construction was successfully created"
    click_on "Back"
  end

  test "should update Resource generator construction" do
    visit resource_generator_construction_url(@resource_generator_construction)
    click_on "Edit this resource generator construction", match: :first

    fill_in "Construction", with: @resource_generator_construction.construction_id
    fill_in "Resource generator type", with: @resource_generator_construction.resource_generator_type
    click_on "Update Resource generator construction"

    assert_text "Resource generator construction was successfully updated"
    click_on "Back"
  end

  test "should destroy Resource generator construction" do
    visit resource_generator_construction_url(@resource_generator_construction)
    click_on "Destroy this resource generator construction", match: :first

    assert_text "Resource generator construction was successfully destroyed"
  end
end
