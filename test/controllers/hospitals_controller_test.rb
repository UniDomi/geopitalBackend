require 'test_helper'

class HospitalsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get hospitals_index_url
    assert_response :success
  end

  test "should get new" do
    get hospitals_new_url
    assert_response :success
  end

  test "should get parse" do
    get hospitals_parse_url
    assert_response :success
  end

end
