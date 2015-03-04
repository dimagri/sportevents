# == Schema Information
#
# Table name: locations
#
#  id                :integer          not null, primary key
#  address           :string
#  latitude          :float
#  longitude         :float
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  locationable_id   :integer
#  locationable_type :string
#

require "spec_helper"
require "rails_helper"

describe Location do

  before(:each) do
    @location = Location.new(
      latitude: 0.0,
      longitude: 0.0,
      locationable: Club.new)
  end

  it "is valid with locationable, latitude and longitude" do
    expect(@location).to be_valid
  end

  it "is invalid without locationable" do
    @location.locationable = nil
    expect(@location).to have(1).errors_on(:locationable)
  end

  it "is invalid without longitude" do
    @location.longitude = nil
    expect(@location).to have(1).errors_on(:longitude)
  end

  it "is invalid without latitude" do
    @location.latitude = nil
    expect(@location).to have(1).errors_on(:latitude)
  end

end
