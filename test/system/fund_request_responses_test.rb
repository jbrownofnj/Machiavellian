require "application_system_test_case"

class FundRequestResponsesTest < ApplicationSystemTestCase
  setup do
    @fund_request_response = fund_request_responses(:one)
  end

  test "visiting the index" do
    visit fund_request_responses_url
    assert_selector "h1", text: "Fund request responses"
  end

  test "should create fund request response" do
    visit fund_request_responses_url
    click_on "New fund request response"

    fill_in "Funding request", with: @fund_request_response.funding_request_id
    fill_in "Funding request player role", with: @fund_request_response.funding_request_player_role_id
    fill_in "Funding request response type", with: @fund_request_response.funding_request_response_type
    click_on "Create Fund request response"

    assert_text "Fund request response was successfully created"
    click_on "Back"
  end

  test "should update Fund request response" do
    visit fund_request_response_url(@fund_request_response)
    click_on "Edit this fund request response", match: :first

    fill_in "Funding request", with: @fund_request_response.funding_request_id
    fill_in "Funding request player role", with: @fund_request_response.funding_request_player_role_id
    fill_in "Funding request response type", with: @fund_request_response.funding_request_response_type
    click_on "Update Fund request response"

    assert_text "Fund request response was successfully updated"
    click_on "Back"
  end

  test "should destroy Fund request response" do
    visit fund_request_response_url(@fund_request_response)
    click_on "Destroy this fund request response", match: :first

    assert_text "Fund request response was successfully destroyed"
  end
end
