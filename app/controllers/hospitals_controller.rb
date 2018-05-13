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
    @hospital.latitude = (@coordinates[0])
    @hospital.longitude = (@coordinates[1])
    @hospital.save
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
          @attribute = @hosp.hospital_attributes.create(code:attr[0], value:attr[1], year:2016, attribute_type:"string")
        end
      end
      j += 1
    end
  end
end
