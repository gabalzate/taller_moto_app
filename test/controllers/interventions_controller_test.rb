require "test_helper"

class InterventionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get interventions_index_url
    assert_response :success
  end

  test "should get show" do
    get interventions_show_url
    assert_response :success
  end

  test "should get new" do
    get interventions_new_url
    assert_response :success
  end

  test "should get create" do
    get interventions_create_url
    assert_response :success
  end

  test "should get edit" do
    get interventions_edit_url
    assert_response :success
  end

  test "should get update" do
    get interventions_update_url
    assert_response :success
  end

  test "should get destroy" do
    get interventions_destroy_url
    assert_response :success
  end
end
