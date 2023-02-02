require "test_helper"

class FundingRequestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @funding_request = funding_requests(:one)
  end

  test "should get index" do
    get funding_requests_url
    assert_response :success
  end

  test "should get new" do
    get new_funding_request_url
    assert_response :success
  end

  test "should create funding_request" do
    assert_difference("FundingRequest.count") do
      post funding_requests_url, params: { funding_request: { construction_id: @funding_request.construction_id, round_id: @funding_request.round_id } }
    end

    assert_redirected_to funding_request_url(FundingRequest.last)
  end

  test "should show funding_request" do
    get funding_request_url(@funding_request)
    assert_response :success
  end

  test "should get edit" do
    get edit_funding_request_url(@funding_request)
    assert_response :success
  end

  test "should update funding_request" do
    patch funding_request_url(@funding_request), params: { funding_request: { construction_id: @funding_request.construction_id, round_id: @funding_request.round_id } }
    assert_redirected_to funding_request_url(@funding_request)
  end

  test "should destroy funding_request" do
    assert_difference("FundingRequest.count", -1) do
      delete funding_request_url(@funding_request)
    end

    assert_redirected_to funding_requests_url
  end
end
