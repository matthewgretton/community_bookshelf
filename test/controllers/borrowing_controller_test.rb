require "test_helper"

class BorrowingControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get borrowing_index_url
    assert_response :success
  end
end
