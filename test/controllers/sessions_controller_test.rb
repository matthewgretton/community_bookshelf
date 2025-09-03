require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get magic" do
    get sessions_magic_url
    assert_response :success
  end
end
