require "application_system_test_case"

class FundingsTest < ApplicationSystemTestCase
  setup do
    @funding = fundings(:one)
  end

  test "visiting the index" do
    visit fundings_url
    assert_selector "h1", text: "Fundings"
  end

  test "should create funding" do
    visit fundings_url
    click_on "New funding"

    fill_in "Construction", with: @funding.construction_id
    fill_in "Funding resource amount", with: @funding.funding_resource_amount
    fill_in "Funding resource type", with: @funding.funding_resource_type
    click_on "Create Funding"

    assert_text "Funding was successfully created"
    click_on "Back"
  end

  test "should update Funding" do
    visit funding_url(@funding)
    click_on "Edit this funding", match: :first

    fill_in "Construction", with: @funding.construction_id
    fill_in "Funding resource amount", with: @funding.funding_resource_amount
    fill_in "Funding resource type", with: @funding.funding_resource_type
    click_on "Update Funding"

    assert_text "Funding was successfully updated"
    click_on "Back"
  end

  test "should destroy Funding" do
    visit funding_url(@funding)
    click_on "Destroy this funding", match: :first

    assert_text "Funding was successfully destroyed"
  end
end
