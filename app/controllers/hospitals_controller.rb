class HospitalsController < ApplicationController
  require 'geocoder'
  def index
    @hospitals = Hospital.all
  end

  def details
    @hospital = Hospital.find(params[:id])
  end

  def new
    @hospital = Hospital.find(params[:id])
    address = @hospital.streetAndNumber + ", " + @hospital.zipCodeAndCity
    @coordinates = Geocoder.coordinates(address)
    if !@coordinates == nil
      @hospital.latitude = (@coordinates[0])
      @hospital.longitude = (@coordinates[1])
      @hospital.save
    else
      @coordinates = 'No coordinates found'
    end
  end

  def parse
    @upload = Upload.find(params[:id])
    @name = (params[:sheet])
    @data = Spreadsheet.open 'public'+@upload.attachment_url
    @sheet = @data.worksheet @name
    @legend = @sheet.row(0)
    @hosps = Array.new
    j = 1
    while j < @sheet.rows.length
      @hospital = @sheet.row(j)
      @hospData = Hash.new
      i = 0
      while i < @legend.length
        @hospData.store(@legend[i], @hospital[i])
        i += 1
      end
      if !Hospital.exists?(name: @hospData["Inst"])
        @hosp = Hospital.create(name:@hospData["Inst"], streetAndNumber:@hospData["Adr"], zipCodeAndCity:@hospData["Ort"])
        #@hospData.delete("Inst")
        #@hospData.delete("Adr")
        #@hospData.delete("Ort")
        @hospData.each do |attr|
          @attribute = @hosp.hospital_attributes.create(code:attr[0], value:attr[1], year:2016)
        end
      end
      j += 1
    end
  end

  def coords
    # DEMOCOORDS AT THE MOMENT!
     @hospitals = Hospital.where(latitude: nil)
     @errors = Array.new
     @hospitals.each do |hospital|
       if hospital.streetAndNumber == nil || hospital.zipCodeAndCity == nil
         @errors << 'No address found for: ' + hospital.name
         next
       end
       lat = 46.905053 + rand(-1..1)
       lon =  7.981008 + rand(-2..2)
       hospital.latitude = lat
       hospital.longitude = lon
       hospital.save
       hospital.hospital_locations.each do |loc|
         lat = 46.905053 + rand(-1..1)
         lon =  7.981008 + rand(-2..2)
         loc.latitude = lat
         loc.longitude = lon
         loc.save
       end
       /
       address = hospital.streetAndNumber + ", " + hospital.zipCodeAndCity
       sleep(1)
       @coordinates = Geocoder.coordinates(address)
       if !@coordinates == nil
         hospital.latitude = (@coordinates[0])
         hospital.longitude = (@coordinates[1])
         hospital.save
       else
         @errors << 'No coordinates found for: ' + hospital.name + ' ' + address
       end
       /
     end
   end
end
