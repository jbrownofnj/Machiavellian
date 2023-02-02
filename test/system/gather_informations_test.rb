require "application_system_test_case"

class GatherInformationsTest < ApplicationSystemTestCase
  setup do
    @gather_information = gather_informations(:one)
  end

  test "visiting the index" do
    visit gather_informations_url
    assert_selector "h1", text: "Gather information"
  end

  test "should create gather information" do
    visit gather_informations_url
    click_on "New gather information"

    fill_in "Information type", with: @gather_information.information_type
    fill_in "Player action", with: @gather_information.player_action_id
    click_on "Create Gather information"

    assert_text "Gather information was successfully created"
    click_on "Back"
  end

  test "should update Gather information" do
    visit gather_information_url(@gather_information)
    click_on "Edit this gather information", match: :first

    fill_in "Information type", with: @gather_information.information_type
    fill_in "Player action", with: @gather_information.player_action_id
    click_on "Update Gather information"

    assert_text "Gather information was successfully updated"
    click_on "Back"
  end

  test "should destroy Gather information" do
    visit gather_information_url(@gather_information)
    click_on "Destroy this gather information", match: :first

    assert_text "Gather information was successfully destroyed"
  end
end
