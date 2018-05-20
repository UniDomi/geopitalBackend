include LocationsHelper

class LocationsController < ApplicationController

  def parse
    read_and_store_locations(Upload.find(params[:id]), params[:sheet])
  end
end
