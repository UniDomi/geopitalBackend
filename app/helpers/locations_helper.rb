module LocationsHelper

  def read_and_store_locations(upload, sheet_name)
    @data = Spreadsheet.open 'public'+upload.attachment_url
    @sheet = @data.worksheet sheet_name
    @legend = @sheet.row(0)
    @hospitals = Array.new
    @locs = Array.new
    @errors = Array.new
    j = 1
    while j < @sheet.rows.length
      @location = @sheet.row(j)
      @data = Hash.new
      i = 0
      while i < @legend.length
        @data.store(@legend[i], @location[i])
        i += 1
      end
      @hospital = Hospital.where(name: @data["Inst"]).first
      if @hospital == nil
        @errors << 'Not found ' + @data["Inst"]
      else
        if !@hospital.streetAndNumber.equal?(@data["Adr_Standort"])
          @locs << @hospital.hospital_locations.create(name: @data["Standort"], kanton: @data["KT"], streetAndNumber: @data["Adr_Standort"], zipCodeAndCity: @data["Ort_Standort"], la: @data["LA"])
        end
      end
      j += 1
    end
  end

end
