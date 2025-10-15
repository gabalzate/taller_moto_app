require "test_helper"

class ProcedureSheetsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get procedure_sheets_new_url
    assert_response :success
  end

  test "should get create" do
    get procedure_sheets_create_url
    assert_response :success
  end

  test "should get show" do
    get procedure_sheets_show_url
    assert_response :success
  end

  test "should get edit" do
    get procedure_sheets_edit_url
    assert_response :success
  end

  test "should get update" do
    get procedure_sheets_update_url
    assert_response :success
  end
end
