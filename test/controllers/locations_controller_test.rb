require 'test_helper'

class LocationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get locations_index_url
    assert_response :success
  end

  test "should get details" do
    get locations_details_url
    assert_response :success
  end

  test "should get coords" do
    get locations_coords_url
    assert_response :success
  end

  test "should get parse" do
    get locations_parse_url
    assert_response :success
  end

end
