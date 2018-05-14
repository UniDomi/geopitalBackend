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
     @hospitales = Hospital.where(latitude: nil).limit(1)
     @hospitals = @hospitales
     @errors = Array.new
     @hospitals.each do |hospital|
       if hospital.streetAndNumber == nil || hospital.zipCodeAndCity == nil
         @errors << 'No address found for: ' + hospital.name
         next
       end
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
     end
   end
end
