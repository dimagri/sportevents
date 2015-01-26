# == Schema Information
#
# Table name: locations
#
#  id         :integer          not null, primary key
#  adress     :string
#  latitude   :float
#  longitude  :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Location < ActiveRecord::Base

  belongs_to :club

  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode

  validates :latitude, :longitude, presence: true

end
