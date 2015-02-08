module Locationable
  extend ActiveSupport::Concern

  included do
    before_action :create_location, only: [ :create, :update ]
  end

  def create_location
    if params[:location].nil?
      redirect_to :back, alert: 'Поставьте метку на карте'
      return
    end
    loc_params = params[:location].split(' ')
    @location = Location.create(latitude: loc_params[0], longitude: loc_params[1])
  end
end