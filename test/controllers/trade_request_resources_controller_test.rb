require "test_helper"

class TradeRequestResourcesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @trade_request_resource = trade_request_resources(:one)
  end

  test "should get index" do
    get trade_request_resources_url
    assert_response :success
  end

  test "should get new" do
    get new_trade_request_resource_url
    assert_response :success
  end

  test "should create trade_request_resource" do
    assert_difference("TradeRequestResource.count") do
      post trade_request_resources_url, params: { trade_request_resource: { trade_request_id: @trade_request_resource.trade_request_id, trade_request_resource_quantity: @trade_request_resource.trade_request_resource_quantity, trade_request_resource_type: @trade_request_resource.trade_request_resource_type } }
    end

    assert_redirected_to trade_request_resource_url(TradeRequestResource.last)
  end

  test "should show trade_request_resource" do
    get trade_request_resource_url(@trade_request_resource)
    assert_response :success
  end

  test "should get edit" do
    get edit_trade_request_resource_url(@trade_request_resource)
    assert_response :success
  end

  test "should update trade_request_resource" do
    patch trade_request_resource_url(@trade_request_resource), params: { trade_request_resource: { trade_request_id: @trade_request_resource.trade_request_id, trade_request_resource_quantity: @trade_request_resource.trade_request_resource_quantity, trade_request_resource_type: @trade_request_resource.trade_request_resource_type } }
    assert_redirected_to trade_request_resource_url(@trade_request_resource)
  end

  test "should destroy trade_request_resource" do
    assert_difference("TradeRequestResource.count", -1) do
      delete trade_request_resource_url(@trade_request_resource)
    end

    assert_redirected_to trade_request_resources_url
  end
end
