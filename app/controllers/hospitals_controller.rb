class HospitalsController < ApplicationController
  def index
  end

  def new
  end

  def parse
    @upload = Upload.find(params[:id])
    @name = (params[:sheet])
    @data = Spreadsheet.open 'public'+@upload.attachment_url
    @sheet = @data.worksheet @name
    @legend = @sheet.row(0)
    @hospital = @sheet.row(1)
    @test = Hash.new
    i = 0
    while i < @legend.length
      @test.store(@legend[i], @hospital[i])
    end
    
  end
end
