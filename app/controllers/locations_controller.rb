class LocationsController < ApplicationController
  def index
  end

  def details
  end

  def coords
  end

  def parse
    @upload = Upload.find(params[:id])
    @name = (params[:sheet])
    @data = Spreadsheet.open 'public'+@upload.attachment_url
    @sheet = @data.worksheet @name
    @legend = @sheet.row(0)
    @locs = Array.new
    j = 1
    while j <  5#@sheet.rows.length
      @location = @sheet.row(j)
      @data = Hash.new
      i = 0
      while i < @legend.length
        @data.store(@legend[i], @location[i])
        i += 1
        @locs << @data
      end
      #if !Hospital.exists?(name: @hospData["Inst"])
      #  @hosp = Hospital.create(name:@hospData["Inst"], streetAndNumber:@hospData["Adr"], zipCodeAndCity:@hospData["Ort"])
        #@hospData.delete("Inst")
        #@hospData.delete("Adr")
        #@hospData.delete("Ort")
      #  @hospData.each do |attr|
      #    @attribute = @hosp.hospital_attributes.create(code:attr[0], value:attr[1], year:2016, attribute_type:"string")
      #  end
      #end
      j += 1
    end
    @hospital = Hospital.where(name: 'RehaClinic Baden')
    @locs << @hospital
    
  end
end
