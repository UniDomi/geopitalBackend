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
    @hospital = @sheet.row(2)
    @test = Hash.new
    i = 0
    while i < @legend.length
      @test.store(@legend[i], @hospital[i])
      i += 1
    end
    @hosp = Hospital.create(name:@test["Inst"], streetAndNumber:@test["Adr"], zipCodeAndCity:@test["Ort"])
  end
end
