require "test_helper"

class TradeRequestResponsesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @trade_request_response = trade_request_responses(:one)
  end

  test "should get index" do
    get trade_request_responses_url
    assert_response :success
  end

  test "should get new" do
    get new_trade_request_response_url
    assert_response :success
  end

  test "should create trade_request_response" do
    assert_difference("TradeRequestResponse.count") do
      post trade_request_responses_url, params: { trade_request_response: { trade_player_role_id: @trade_request_response.trade_player_role_id, trade_request_id: @trade_request_response.trade_request_id, trade_response_type: @trade_request_response.trade_response_type } }
    end

    assert_redirected_to trade_request_response_url(TradeRequestResponse.last)
  end

  test "should show trade_request_response" do
    get trade_request_response_url(@trade_request_response)
    assert_response :success
  end

  test "should get edit" do
    get edit_trade_request_response_url(@trade_request_response)
    assert_response :success
  end

  test "should update trade_request_response" do
    patch trade_request_response_url(@trade_request_response), params: { trade_request_response: { trade_player_role_id: @trade_request_response.trade_player_role_id, trade_request_id: @trade_request_response.trade_request_id, trade_response_type: @trade_request_response.trade_response_type } }
    assert_redirected_to trade_request_response_url(@trade_request_response)
  end

  test "should destroy trade_request_response" do
    assert_difference("TradeRequestResponse.count", -1) do
      delete trade_request_response_url(@trade_request_response)
    end

    assert_redirected_to trade_request_responses_url
  end
end
