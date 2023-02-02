require "test_helper"

class GatherInformationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @gather_information = gather_informations(:one)
  end

  test "should get index" do
    get gather_informations_url
    assert_response :success
  end

  test "should get new" do
    get new_gather_information_url
    assert_response :success
  end

  test "should create gather_information" do
    assert_difference("GatherInformation.count") do
      post gather_informations_url, params: { gather_information: { information_type: @gather_information.information_type, player_action_id: @gather_information.player_action_id } }
    end

    assert_redirected_to gather_information_url(GatherInformation.last)
  end

  test "should show gather_information" do
    get gather_information_url(@gather_information)
    assert_response :success
  end

  test "should get edit" do
    get edit_gather_information_url(@gather_information)
    assert_response :success
  end

  test "should update gather_information" do
    patch gather_information_url(@gather_information), params: { gather_information: { information_type: @gather_information.information_type, player_action_id: @gather_information.player_action_id } }
    assert_redirected_to gather_information_url(@gather_information)
  end

  test "should destroy gather_information" do
    assert_difference("GatherInformation.count", -1) do
      delete gather_information_url(@gather_information)
    end

    assert_redirected_to gather_informations_url
  end
end
