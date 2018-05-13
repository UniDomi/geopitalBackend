require 'test_helper'

class AttributeTypesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get attribute_types_index_url
    assert_response :success
  end

  test "should get new" do
    get attribute_types_new_url
    assert_response :success
  end

  #test "should get parse" do
   # get attribute_types_parse_url
    #assert_response :success
  #end

end
