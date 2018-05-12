require 'test_helper'

class HospitalTest < ActiveSupport::TestCase
  
  def setup
  	@hospital = Hospital.new(name: "Hospital Example", streetAndNumber: "Street 12", zipCodeAndCity: "1000 City", longitude: 12.34567, latitude: 98.76543)
  end

  test "should be valid" do
  	assert @hospital.valid?
  end

  test "name should be present" do
  	@hospital.name = ""
  	assert_not @hospital.valid?
  end

end
