class HospitalsController < ApplicationController
  def index
    @hospitals = Hospital.all
  end

  def new
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
        @hosps << Hospital.create(name:@hospData["Inst"], streetAndNumber:@hospData["Adr"], zipCodeAndCity:@hospData["Ort"])
        #@hospData.delete("Inst")
        #@hospData.delete("Adr")
        #@hospData.delete("Ort")
      end
      j += 1
    end
  end
end
