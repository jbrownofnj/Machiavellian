require "application_system_test_case"

class TradeRequestResponsesTest < ApplicationSystemTestCase
  setup do
    @trade_request_response = trade_request_responses(:one)
  end

  test "visiting the index" do
    visit trade_request_responses_url
    assert_selector "h1", text: "Trade request responses"
  end

  test "should create trade request response" do
    visit trade_request_responses_url
    click_on "New trade request response"

    fill_in "Trade player role", with: @trade_request_response.trade_player_role_id
    fill_in "Trade request", with: @trade_request_response.trade_request_id
    fill_in "Trade response type", with: @trade_request_response.trade_response_type
    click_on "Create Trade request response"

    assert_text "Trade request response was successfully created"
    click_on "Back"
  end

  test "should update Trade request response" do
    visit trade_request_response_url(@trade_request_response)
    click_on "Edit this trade request response", match: :first

    fill_in "Trade player role", with: @trade_request_response.trade_player_role_id
    fill_in "Trade request", with: @trade_request_response.trade_request_id
    fill_in "Trade response type", with: @trade_request_response.trade_response_type
    click_on "Update Trade request response"

    assert_text "Trade request response was successfully updated"
    click_on "Back"
  end

  test "should destroy Trade request response" do
    visit trade_request_response_url(@trade_request_response)
    click_on "Destroy this trade request response", match: :first

    assert_text "Trade request response was successfully destroyed"
  end
end
