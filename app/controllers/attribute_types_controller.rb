include AttributeTypesHelper

class AttributeTypesController < ApplicationController
  def index
    @types = AttributeType.all
  end

  def parse
    read_and_store_attributes_types(Upload.find(params[:id]), params[:sheet])
  end
end
