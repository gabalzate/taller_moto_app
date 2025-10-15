require "test_helper"

class OutputSheetsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get output_sheets_new_url
    assert_response :success
  end

  test "should get create" do
    get output_sheets_create_url
    assert_response :success
  end

  test "should get show" do
    get output_sheets_show_url
    assert_response :success
  end

  test "should get edit" do
    get output_sheets_edit_url
    assert_response :success
  end

  test "should get update" do
    get output_sheets_update_url
    assert_response :success
  end
end
