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
    if @coordinates != nil
      hospital.latitude = @coordinates[0]
      hospital.longitude = @coordinates[1]
      hospital.save
    else
      return 'No coordinates found for: ' + hospital.name + ' ' + address
    end
  end

  def read_and_store_hospitals(upload, sheet_name)
    @data = Spreadsheet.open 'public'+upload.attachment_url
    @sheet = @data.worksheet sheet_name
    @legend = @sheet.row(0)
    @hosps = Array.new
    @year = sheet_name.gsub(/[^0-9]/,'')[0..3]

    j = 0
    while j < 10
      @hospital = @sheet.row(j)
      @hospData = Hash.new
      i = 0
      while i < @legend.length
        @hospData.store(@legend[i], @hospital[i])
        @hospData.delete("Amb")
        @hospData.delete("Stat")
        @hospData.delete("Amb, Stat")
        i += 1
      end
      if !Hospital.exists?(name: @hospData["Inst"])
        @hosp = Hospital.create(name:@hospData["Inst"], streetAndNumber:@hospData["Adr"], zipCodeAndCity:@hospData["Ort"])
      else
        @hosp = Hospital.where(name:@hospData["Inst"]).first
      end
      @hospData.each do |attr|
        @attribute = @hosp.hospital_attributes.create(code:attr[0], value:attr[1], year:@year)
      end
      j += 1
    end
  end

end
