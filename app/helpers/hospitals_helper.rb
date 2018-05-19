module HospitalsHelper
  def get_coordinates(hospital)
    if hospital.zipCodeAndCity == nil
      return 'No address found for: ' + hospital.name
    end
    if hospital.streetAndNumber == nil
      address = hospital.zipCodeAndCity
    else
      address = hospital.streetAndNumber + ", " + hospital.zipCodeAndCity
    end
    sleep(0.2)
    begin
      @coordinates = Geocoder.coordinates(address)
    rescue => error
      return 'No coordinates found for: ' + hospital.name + ' ' + address
    end
    hospital.latitude = @coordinates[0]
    hospital.longitude = @coordinates[1]
    hospital.save
   end
end
