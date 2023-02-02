require "application_system_test_case"

class FundingRequestResourcesTest < ApplicationSystemTestCase
  setup do
    @funding_request_resource = funding_request_resources(:one)
  end

  test "visiting the index" do
    visit funding_request_resources_url
    assert_selector "h1", text: "Funding request resources"
  end

  test "should create funding request resource" do
    visit funding_request_resources_url
    click_on "New funding request resource"

    fill_in "Funding request", with: @funding_request_resource.funding_request_id
    fill_in "Funding resource amount", with: @funding_request_resource.funding_resource_amount
    fill_in "Funding resource type", with: @funding_request_resource.funding_resource_type
    click_on "Create Funding request resource"

    assert_text "Funding request resource was successfully created"
    click_on "Back"
  end

  test "should update Funding request resource" do
    visit funding_request_resource_url(@funding_request_resource)
    click_on "Edit this funding request resource", match: :first

    fill_in "Funding request", with: @funding_request_resource.funding_request_id
    fill_in "Funding resource amount", with: @funding_request_resource.funding_resource_amount
    fill_in "Funding resource type", with: @funding_request_resource.funding_resource_type
    click_on "Update Funding request resource"

    assert_text "Funding request resource was successfully updated"
    click_on "Back"
  end

  test "should destroy Funding request resource" do
    visit funding_request_resource_url(@funding_request_resource)
    click_on "Destroy this funding request resource", match: :first

    assert_text "Funding request resource was successfully destroyed"
  end
end
