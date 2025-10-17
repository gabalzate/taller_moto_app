require "test_helper"

class Public::WorkshopsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get public_workshops_show_url
    assert_response :success
  end
end
