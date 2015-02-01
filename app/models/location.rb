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

class Location < ActiveRecord::Base

  belongs_to :locationable, polymorphic: true

  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode

  validates :locationable, :latitude, :longitude, presence: true

end
