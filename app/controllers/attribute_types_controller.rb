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
      i = 1
      s = 'string'
      while i < @sheet.rows.length
        row = @sheet.row(i)
        if row[0].present?
          if row[1].present?
            @code = (row[0]+row[1])
          else
            @code = (row[0])
          end
        else
          if row[2].present?
            s = 'number'
          end
        end
        if @code == 'AnzStand'
          s = 'number'
        end
        if @code == 'Amb' || @code == 'Stat' || @code == 'Amb, Stat'
          i += 1
          next
        end
        if !AttributeType.where(code: @code).exists? || @code.equal?('KZ-Code')
          @types << AttributeType.create(code: @code, nameDE: row[2], nameFR: row[3], nameIT: row[4], category: s)
        end
        i += 1
      end
    end
  end
end
