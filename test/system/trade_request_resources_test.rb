require "application_system_test_case"

class TradeRequestResourcesTest < ApplicationSystemTestCase
  setup do
    @trade_request_resource = trade_request_resources(:one)
  end

  test "visiting the index" do
    visit trade_request_resources_url
    assert_selector "h1", text: "Trade request resources"
  end

  test "should create trade request resource" do
    visit trade_request_resources_url
    click_on "New trade request resource"

    fill_in "Trade request", with: @trade_request_resource.trade_request_id
    fill_in "Trade request resource quantity", with: @trade_request_resource.trade_request_resource_quantity
    fill_in "Trade request resource type", with: @trade_request_resource.trade_request_resource_type
    click_on "Create Trade request resource"

    assert_text "Trade request resource was successfully created"
    click_on "Back"
  end

  test "should update Trade request resource" do
    visit trade_request_resource_url(@trade_request_resource)
    click_on "Edit this trade request resource", match: :first

    fill_in "Trade request", with: @trade_request_resource.trade_request_id
    fill_in "Trade request resource quantity", with: @trade_request_resource.trade_request_resource_quantity
    fill_in "Trade request resource type", with: @trade_request_resource.trade_request_resource_type
    click_on "Update Trade request resource"

    assert_text "Trade request resource was successfully updated"
    click_on "Back"
  end

  test "should destroy Trade request resource" do
    visit trade_request_resource_url(@trade_request_resource)
    click_on "Destroy this trade request resource", match: :first

    assert_text "Trade request resource was successfully destroyed"
  end
end
