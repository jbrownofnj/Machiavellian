require "test_helper"

class LoginControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get login_new_url
    assert_response :success
  end

  test "should get create" do
    get login_create_url
    assert_response :success
  end
end
