require 'test_helper'

class AddressTest < ActiveSupport::TestCase
  
  def setup
  	@address = Address.new(streetAndNumber: "Street 12", plzAndCity: "1000 City")
  end

  test "should be valid" do
  	assert @address.valid?
  end

end
