require 'test_helper'

class HospitalsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @upload = Upload.create(name: "upload", attachment: 'files/kzp16_daten.xls')
    @id = @upload.id
  end

  test "should get index" do
    get hospitals_index_url
    assert_response :success
  end

  #test "should get new" do
    #get hospitals_new_path(id: "Insel")
    #assert_response :success
  #end

  test "should get parse" do
    post hospitals_parse_url, params: { id: @id }
    assert_response :success
  end

end
