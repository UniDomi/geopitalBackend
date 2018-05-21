require 'test_helper'
include LocationsHelper
include HospitalsHelper

class LocationsHelperTest < ActionDispatch::IntegrationTest

  test "should store locations from excel" do
    sheet_name_loc = "Standorte 2016 KZP16"
    sheet_name_hosp = "KZ2016_KZP16"
    data = Spreadsheet.open  Rails.root.join("test/fixtures/files/kzp16_daten.xls")
    sheet_loc = data.worksheet sheet_name_loc
    sheet_hosp = data.worksheet sheet_name_hosp

    read_and_store_hospitals(sheet_hosp, sheet_name_hosp)
    read_and_store_locations(sheet_loc)
    hospital_without_loc_id = Hospital.find_by_name("RehaClinic Baden").id
    hospital_with_loc_id = Hospital.find_by_name("Groupement Hospitalier de l'Ouest Lémanique (GHOL) SA").id
    assert_nil HospitalLocation.find_by_hospital_id(hospital_without_loc_id)
    assert_not_nil HospitalLocation.find_by_hospital_id(hospital_with_loc_id)
    #assert hospital_with_loc.hospital_locations.name == "Hôpital de Rolle"
  end

end