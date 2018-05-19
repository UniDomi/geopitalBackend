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
    @year = @name[2..5]
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
      if hospital.streetAndNumber == nil || hospital.zipCodeAndCity == nil
        @errors << 'No address found for: ' + hospital.name
      else
        address = hospital.streetAndNumber + ", " + hospital.zipCodeAndCity
        sleep(1)
        @coordinates = Geocoder.coordinates(address)
        if @coordinates != nil
          hospital.latitude = @coordinates[0]
          hospital.longitude = @coordinates[1]
          hospital.save
        else
          @errors << 'No coordinates found for: ' + hospital.name + ' ' + address
        end
        hospital.hospital_locations.each do |loc|
          if loc.streetAndNumber == nil || loc.zipCodeAndCity == nil
            @errors << 'No address found for: ' + loc.name
            next
          end
          loc_address = loc.streetAndNumber + ", " + loc.zipCodeAndCity
          if address == loc_address
            loc.latitude = hospital.latitude
            loc.longitude = hospital.longitude
          else
            sleep(1)
            @coordinates = Geocoder.coordinates(loc_address)
            if @coordinates != nil
              loc.latitude = @coordinates[0]
              loc.longitude = @coordinates[1]
              loc.save
            else
              @errors << 'No coordinates found for: ' + hospital.name + ' ' + address
            end
          end
        end
      end
    end
  end
end
