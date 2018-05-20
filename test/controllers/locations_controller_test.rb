require 'test_helper'

class LocationsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @upload = Upload.create(name: "upload", attachment: 'files/kzp16_daten.xls')
    @id = @upload.id
  end

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
    post locations_parse_url, params: { id: 2 }
    assert_response :success
  end

end
