require "test_helper"

class TradeRequestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @trade_request = trade_requests(:one)
  end

  test "should get index" do
    get trade_requests_url
    assert_response :success
  end

  test "should get new" do
    get new_trade_request_url
    assert_response :success
  end

  test "should create trade_request" do
    assert_difference("TradeRequest.count") do
      post trade_requests_url, params: { trade_request: { round_id: @trade_request.round_id } }
    end

    assert_redirected_to trade_request_url(TradeRequest.last)
  end

  test "should show trade_request" do
    get trade_request_url(@trade_request)
    assert_response :success
  end

  test "should get edit" do
    get edit_trade_request_url(@trade_request)
    assert_response :success
  end

  test "should update trade_request" do
    patch trade_request_url(@trade_request), params: { trade_request: { round_id: @trade_request.round_id } }
    assert_redirected_to trade_request_url(@trade_request)
  end

  test "should destroy trade_request" do
    assert_difference("TradeRequest.count", -1) do
      delete trade_request_url(@trade_request)
    end

    assert_redirected_to trade_requests_url
  end
end
