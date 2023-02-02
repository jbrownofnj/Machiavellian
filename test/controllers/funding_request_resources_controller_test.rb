require "test_helper"

class FundingRequestResourcesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @funding_request_resource = funding_request_resources(:one)
  end

  test "should get index" do
    get funding_request_resources_url
    assert_response :success
  end

  test "should get new" do
    get new_funding_request_resource_url
    assert_response :success
  end

  test "should create funding_request_resource" do
    assert_difference("FundingRequestResource.count") do
      post funding_request_resources_url, params: { funding_request_resource: { funding_request_id: @funding_request_resource.funding_request_id, funding_resource_amount: @funding_request_resource.funding_resource_amount, funding_resource_type: @funding_request_resource.funding_resource_type } }
    end

    assert_redirected_to funding_request_resource_url(FundingRequestResource.last)
  end

  test "should show funding_request_resource" do
    get funding_request_resource_url(@funding_request_resource)
    assert_response :success
  end

  test "should get edit" do
    get edit_funding_request_resource_url(@funding_request_resource)
    assert_response :success
  end

  test "should update funding_request_resource" do
    patch funding_request_resource_url(@funding_request_resource), params: { funding_request_resource: { funding_request_id: @funding_request_resource.funding_request_id, funding_resource_amount: @funding_request_resource.funding_resource_amount, funding_resource_type: @funding_request_resource.funding_resource_type } }
    assert_redirected_to funding_request_resource_url(@funding_request_resource)
  end

  test "should destroy funding_request_resource" do
    assert_difference("FundingRequestResource.count", -1) do
      delete funding_request_resource_url(@funding_request_resource)
    end

    assert_redirected_to funding_request_resources_url
  end
end
