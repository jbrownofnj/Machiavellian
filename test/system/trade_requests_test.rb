require "application_system_test_case"

class TradeRequestsTest < ApplicationSystemTestCase
  setup do
    @trade_request = trade_requests(:one)
  end

  test "visiting the index" do
    visit trade_requests_url
    assert_selector "h1", text: "Trade requests"
  end

  test "should create trade request" do
    visit trade_requests_url
    click_on "New trade request"

    fill_in "Round", with: @trade_request.round_id
    click_on "Create Trade request"

    assert_text "Trade request was successfully created"
    click_on "Back"
  end

  test "should update Trade request" do
    visit trade_request_url(@trade_request)
    click_on "Edit this trade request", match: :first

    fill_in "Round", with: @trade_request.round_id
    click_on "Update Trade request"

    assert_text "Trade request was successfully updated"
    click_on "Back"
  end

  test "should destroy Trade request" do
    visit trade_request_url(@trade_request)
    click_on "Destroy this trade request", match: :first

    assert_text "Trade request was successfully destroyed"
  end
end
