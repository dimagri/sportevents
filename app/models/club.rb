# == Schema Information
#
# Table name: clubs
#
#  id           :integer          not null, primary key
#  club_type_id :integer
#  user_id      :integer
#  name         :string
#  description  :text
#  price        :integer
#  phone        :string
#  confirmed    :boolean
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Club < ActiveRecord::Base

  include SportObject, ClubSearch

  belongs_to :type, class_name: 'ClubType', foreign_key: 'club_type_id'

  validates :club_type_id, presence: true

  scope :confirmed, ->{ where(confirmed: true) }
  scope :unconfirmed, ->{ where(confirmed: false) }

  def self.add(club_params, current_user, location)
    Club.new(club_params) do |c|
      c.author = current_user
      c.location = location
    end
  end

  def to_param
    "#{id}-#{name.parameterize}"
  end
  
end
