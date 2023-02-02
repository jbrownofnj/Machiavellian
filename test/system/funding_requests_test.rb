require "application_system_test_case"

class FundingRequestsTest < ApplicationSystemTestCase
  setup do
    @funding_request = funding_requests(:one)
  end

  test "visiting the index" do
    visit funding_requests_url
    assert_selector "h1", text: "Funding requests"
  end

  test "should create funding request" do
    visit funding_requests_url
    click_on "New funding request"

    fill_in "Construction", with: @funding_request.construction_id
    fill_in "Round", with: @funding_request.round_id
    click_on "Create Funding request"

    assert_text "Funding request was successfully created"
    click_on "Back"
  end

  test "should update Funding request" do
    visit funding_request_url(@funding_request)
    click_on "Edit this funding request", match: :first

    fill_in "Construction", with: @funding_request.construction_id
    fill_in "Round", with: @funding_request.round_id
    click_on "Update Funding request"

    assert_text "Funding request was successfully updated"
    click_on "Back"
  end

  test "should destroy Funding request" do
    visit funding_request_url(@funding_request)
    click_on "Destroy this funding request", match: :first

    assert_text "Funding request was successfully destroyed"
  end
end
