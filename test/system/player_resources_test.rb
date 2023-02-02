require "application_system_test_case"

class PlayerResourcesTest < ApplicationSystemTestCase
  setup do
    @player_resource = player_resources(:one)
  end

  test "visiting the index" do
    visit player_resources_url
    assert_selector "h1", text: "Player resources"
  end

  test "should create player resource" do
    visit player_resources_url
    click_on "New player resource"

    fill_in "Player", with: @player_resource.player_id
    fill_in "Resource quantity", with: @player_resource.resource_quantity
    fill_in "Resource type", with: @player_resource.resource_type
    click_on "Create Player resource"

    assert_text "Player resource was successfully created"
    click_on "Back"
  end

  test "should update Player resource" do
    visit player_resource_url(@player_resource)
    click_on "Edit this player resource", match: :first

    fill_in "Player", with: @player_resource.player_id
    fill_in "Resource quantity", with: @player_resource.resource_quantity
    fill_in "Resource type", with: @player_resource.resource_type
    click_on "Update Player resource"

    assert_text "Player resource was successfully updated"
    click_on "Back"
  end

  test "should destroy Player resource" do
    visit player_resource_url(@player_resource)
    click_on "Destroy this player resource", match: :first

    assert_text "Player resource was successfully destroyed"
  end
end
