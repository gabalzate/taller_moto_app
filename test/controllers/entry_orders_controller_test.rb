require "test_helper"

class EntryOrdersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get entry_orders_new_url
    assert_response :success
  end

  test "should get create" do
    get entry_orders_create_url
    assert_response :success
  end

  test "should get show" do
    get entry_orders_show_url
    assert_response :success
  end

  test "should get edit" do
    get entry_orders_edit_url
    assert_response :success
  end

  test "should get update" do
    get entry_orders_update_url
    assert_response :success
  end
end
