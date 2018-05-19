include HospitalsHelper

class HospitalsController < ApplicationController

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
    @year = @name.gsub(/[^0-9]/,'')[0..3]

    j = 1
    while j < @sheet.rows.length
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

  def coords
    @hospitals = Hospital.where(latitude: nil)
    @errors = Array.new
    @hospitals.each do |hospital|
      errors << get_coordinates(hospital)
      hospital.hospital_locations.each do |loc|
        errors << get_coordinates(loc)
      end
    end
  end
end
