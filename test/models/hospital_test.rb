require 'test_helper'

class HospitalTest < ActiveSupport::TestCase
  
  def setup
  	@hospital = Hospital.new(name: "Hospital Example", year: 2015)
  end

  test "should be valid" do
  	assert @hospital.valid?
  end

  test "name should be present" do
  	@hospital.name = ""
  	assert_not @hospital.valid?
  end
end
