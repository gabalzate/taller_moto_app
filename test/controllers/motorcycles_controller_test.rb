require "test_helper"

class MotorcyclesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get motorcycles_index_url
    assert_response :success
  end

  test "should get show" do
    get motorcycles_show_url
    assert_response :success
  end

  test "should get new" do
    get motorcycles_new_url
    assert_response :success
  end

  test "should get create" do
    get motorcycles_create_url
    assert_response :success
  end

  test "should get edit" do
    get motorcycles_edit_url
    assert_response :success
  end

  test "should get update" do
    get motorcycles_update_url
    assert_response :success
  end

  test "should get destroy" do
    get motorcycles_destroy_url
    assert_response :success
  end
end
