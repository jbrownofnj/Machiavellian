require "test_helper"

class FundRequestResponsesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @fund_request_response = fund_request_responses(:one)
  end

  test "should get index" do
    get fund_request_responses_url
    assert_response :success
  end

  test "should get new" do
    get new_fund_request_response_url
    assert_response :success
  end

  test "should create fund_request_response" do
    assert_difference("FundRequestResponse.count") do
      post fund_request_responses_url, params: { fund_request_response: { funding_request_id: @fund_request_response.funding_request_id, funding_request_player_role_id: @fund_request_response.funding_request_player_role_id, funding_request_response_type: @fund_request_response.funding_request_response_type } }
    end

    assert_redirected_to fund_request_response_url(FundRequestResponse.last)
  end

  test "should show fund_request_response" do
    get fund_request_response_url(@fund_request_response)
    assert_response :success
  end

  test "should get edit" do
    get edit_fund_request_response_url(@fund_request_response)
    assert_response :success
  end

  test "should update fund_request_response" do
    patch fund_request_response_url(@fund_request_response), params: { fund_request_response: { funding_request_id: @fund_request_response.funding_request_id, funding_request_player_role_id: @fund_request_response.funding_request_player_role_id, funding_request_response_type: @fund_request_response.funding_request_response_type } }
    assert_redirected_to fund_request_response_url(@fund_request_response)
  end

  test "should destroy fund_request_response" do
    assert_difference("FundRequestResponse.count", -1) do
      delete fund_request_response_url(@fund_request_response)
    end

    assert_redirected_to fund_request_responses_url
  end
end
