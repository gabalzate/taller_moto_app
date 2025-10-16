require "test_helper"

class Public::MotorcyclesControllerTest < ActionDispatch::IntegrationTest
  test "should get search" do
    get public_motorcycles_search_url
    assert_response :success
  end

  test "should get show" do
    get public_motorcycles_show_url
    assert_response :success
  end
end
