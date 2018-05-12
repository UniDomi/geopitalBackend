class AttributeTypesController < ApplicationController
  def index
    @types = AttributeType.all
  end

  def new
  end

  def parse
    @upload = Upload.find(params[:id])
    @name = (params[:sheet])
    @data = Spreadsheet.open 'public'+@upload.attachment_url
    @sheet = @data.worksheet @name
    @codes = Array.new
    @names = Array.new
    @types = Array.new
    if @name = 'Kennzahlen'
      @sheet.each do |row|
        if row[0].present?
          if row[1].present?
            @codes << (row[0]+row[1])
            @code = (row[0]+row[1])
          else
            @codes << (row[0])
            @code = (row[0])
          end
        @names << (row[2])
        @nameDE = (row[2])
        @nameFR = (row[3])
        @nameIT = (row[4])
        end
        if !AttributeType.exists?(code: @code)
          @types << AttributeType.create(code: @code, nameDE: @nameDE, nameFR: @nameFR, nameIT: @nameIT)
        end
      end
    end
  end
end
