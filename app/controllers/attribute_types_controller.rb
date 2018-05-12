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
    @types = Array.new
    if @name == ('Kennzahlen')
      @sheet.each do |row|
        if row[0].present?
          if row[1].present?
            @code = (row[0]+row[1])
          else
            @code = (row[0])
          end
        end
        if !AttributeType.exists?(code: @code) || @code.equal?('KZ-Code')
          @types << AttributeType.create(code: @code, nameDE: row[2], nameFR: row[3], nameIT: row[4])
        end
      end
    end
  end
end
