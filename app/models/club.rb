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

  # TODO add Location field

  belongs_to :type, class_name: 'ClubType', foreign_key: 'club_type_id'
  belongs_to :author, class_name: 'User', foreign_key: 'user_id'
  has_one :location
end
