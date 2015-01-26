class LocationsController < ApplicationController

  def get_location
    @location = { latitude: params[:latitude], longitude: params[:longitude] }
  end

end
