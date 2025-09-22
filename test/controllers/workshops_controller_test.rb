require "test_helper"

class WorkshopsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get workshops_index_url
    assert_response :success
  end

  test "should get show" do
    get workshops_show_url
    assert_response :success
  end

  test "should get new" do
    get workshops_new_url
    assert_response :success
  end

  test "should get create" do
    get workshops_create_url
    assert_response :success
  end

  test "should get edit" do
    get workshops_edit_url
    assert_response :success
  end

  test "should get update" do
    get workshops_update_url
    assert_response :success
  end

  test "should get destroy" do
    get workshops_destroy_url
    assert_response :success
  end
end
