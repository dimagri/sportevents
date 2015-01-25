class HomeController < ApplicationController
  def index
  end

  def get_location
    @location = { latitude: params[:latitude], longitude: params[:longitude] }
  end
end
