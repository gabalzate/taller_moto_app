require "test_helper"

class Public::InterventionsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get public_interventions_show_url
    assert_response :success
  end
end
