class ApiController < ApplicationController
  def hospitals
    @hospitals = Hospital
                     .includes(:hospital_attributes, :hospital_locations)
                     .as_json(include: [:hospital_attributes, :hospital_locations])
    render :json => @hospitals
  end

  def attributeTypes
    @attribute_types = AttributeType.all
    render :json => {:attribute_types => @attribute_types}
  end
end
