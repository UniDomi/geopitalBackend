require 'test_helper'

class HospitalTest < ActiveSupport::TestCase
  
  def setup
  	@hospital = hospitals(:Insel)
  end

  test "should be valid" do
  	assert @hospital.valid?
  end

  test "name should be present" do
  	@hospital.name = ""
  	assert_not @hospital.valid?
  end

  test "name should be unique" do
    @hospital_duplicate = hospitals(:Linde)
    @hospital_duplicate.name = @hospital.name.upcase
    assert_not @hospital_duplicate.valid?
  end

end
