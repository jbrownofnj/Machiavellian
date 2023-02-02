require "application_system_test_case"

class ResourceGeneratorsTest < ApplicationSystemTestCase
  setup do
    @resource_generator = resource_generators(:one)
  end

  test "visiting the index" do
    visit resource_generators_url
    assert_selector "h1", text: "Resource generators"
  end

  test "should create resource generator" do
    visit resource_generators_url
    click_on "New resource generator"

    fill_in "Player", with: @resource_generator.player_id
    fill_in "Resource generator type", with: @resource_generator.resource_generator_type
    click_on "Create Resource generator"

    assert_text "Resource generator was successfully created"
    click_on "Back"
  end

  test "should update Resource generator" do
    visit resource_generator_url(@resource_generator)
    click_on "Edit this resource generator", match: :first

    fill_in "Player", with: @resource_generator.player_id
    fill_in "Resource generator type", with: @resource_generator.resource_generator_type
    click_on "Update Resource generator"

    assert_text "Resource generator was successfully updated"
    click_on "Back"
  end

  test "should destroy Resource generator" do
    visit resource_generator_url(@resource_generator)
    click_on "Destroy this resource generator", match: :first

    assert_text "Resource generator was successfully destroyed"
  end
end
