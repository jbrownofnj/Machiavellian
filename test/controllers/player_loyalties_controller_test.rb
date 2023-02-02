require "test_helper"

class PlayerLoyaltiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @player_loyalty = player_loyalties(:one)
  end

  test "should get index" do
    get player_loyalties_url
    assert_response :success
  end

  test "should get new" do
    get new_player_loyalty_url
    assert_response :success
  end

  test "should create player_loyalty" do
    assert_difference("PlayerLoyalty.count") do
      post player_loyalties_url, params: { player_loyalty: { player_loyalty_quantity: @player_loyalty.player_loyalty_quantity } }
    end

    assert_redirected_to player_loyalty_url(PlayerLoyalty.last)
  end

  test "should show player_loyalty" do
    get player_loyalty_url(@player_loyalty)
    assert_response :success
  end

  test "should get edit" do
    get edit_player_loyalty_url(@player_loyalty)
    assert_response :success
  end

  test "should update player_loyalty" do
    patch player_loyalty_url(@player_loyalty), params: { player_loyalty: { player_loyalty_quantity: @player_loyalty.player_loyalty_quantity } }
    assert_redirected_to player_loyalty_url(@player_loyalty)
  end

  test "should destroy player_loyalty" do
    assert_difference("PlayerLoyalty.count", -1) do
      delete player_loyalty_url(@player_loyalty)
    end

    assert_redirected_to player_loyalties_url
  end
end
