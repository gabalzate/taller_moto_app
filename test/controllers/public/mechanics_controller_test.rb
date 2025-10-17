require "test_helper"

class Public::MechanicsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get public_mechanics_show_url
    assert_response :success
  end
end
