class ApiController < ApplicationController
  def hospitals
    max_year = HospitalAttribute.maximum("year")
    @hospitals = Hospital
                     .includes(:hospital_attributes, :hospital_locations).where(:hospital_attributes => {:year => max_year})
                     .as_json(include: [:hospital_attributes, :hospital_locations])
    render :json => @hospitals
  end

  def attributeTypes
    @attribute_types = AttributeType.all
    render :json => {:attribute_types => @attribute_types}
  end
end