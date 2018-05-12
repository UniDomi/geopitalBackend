class ParsersController < ApplicationController
  require 'spreadsheet'
  Spreadsheet.client_encoding = 'UTF-8'
  def index
    @uploads = Upload.all
  end

  def details
    @upload = Upload.find(params[:id])
    @data = Spreadsheet.open 'public'+@upload.attachment_url
    @kennZ = @data.worksheet 1
  end

  def parse
    @upload = Upload.find(params[:id])
    @data = Spreadsheet.open 'public'+@upload.attachment_url
    @sheet = @data.worksheets (params[:sheet])
  end
end
