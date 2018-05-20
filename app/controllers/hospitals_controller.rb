include HospitalsHelper

class HospitalsController < ApplicationController

  def index
    @hospitals = Hospital.all
  end

  def details
    @hospital = Hospital.find(params[:id])
  end

  def coords_single
    @hospital = Hospital.find(params[:id])
    error= get_coordinates(@hospital)
    @message = error == nil ? @message = 'Geocoding successfull' : error
  end

  def parse
    read_and_store_hospitals(Upload.find(params[:id]), params[:sheet])
  end

  def coords
    @hospitals = Hospital.where(latitude: nil)
    @errors = Array.new
    @hospitals.each do |hospital|
      errors << get_coordinates(hospital)
      hospital.hospital_locations.each do |loc|
        errors << get_coordinates(loc)
      end
    end
  end
end
