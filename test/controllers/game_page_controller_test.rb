require "test_helper"

class GamePageControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get game_page_new_url
    assert_response :success
  end
end
