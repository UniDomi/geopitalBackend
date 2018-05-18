require 'oj'

class ApiController < ApplicationController
  def hospitals
    #max_year = HospitalAttribute.maximum("year")
    #hospitals = Hospital.includes(:hospital_attributes, :hospital_locations).where(:hospital_attributes => {:year => max_year}).as_json(:except => [:created_at, :updated_at], :include => [:hospital_attributes => {:except => [:created_at, :updated_at]}, :hospital_locations => {:except => [:created_at, :updated_at]}])
    #hospitals = Hospital.first(280).attributes
    @@data = File.read("hospitals.json")
    render :json => @@data#Oj.dump(hospitals)
  end

  def attributeTypes
    #@attribute_types_string = AttributeType.where(:category => "string")
    #@attribute_types_number = AttributeType.where(:category => "number")
    #render :json => {:attribute_types_string => AttributeType.where(:category => "string"), :attribute_types_number => AttributeType.where(:category => "number")}
    @@data = File.read("attributeTypes.json")
    render :json => @@data#Oj.dump(hospitals)
  end
end
