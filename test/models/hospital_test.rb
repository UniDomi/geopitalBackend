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

  test "year should be present" do
  	@hospital.year = nil;
  	assert_not @hospital.valid?
  end

  test "hospital and year should be unique" do
  	duplicate_hospital = @hospital.dup
  	@hospital.save
  	assert_not duplicate_hospital.valid?
  end

  test "hospital with other year should be valid" do
  	duplicate_hospital = @hospital.dup
  	duplicate_hospital.year = @hospital.year + 1;
  	@hospital.save
  	assert duplicate_hospital.valid?
  end
end
