require "test_helper"

class Admin::AccountControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get admin_account_show_url
    assert_response :success
  end
end
