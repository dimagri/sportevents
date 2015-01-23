# == Schema Information
#
# Table name: club_types
#
#  id         :integer          not null, primary key
#  name       :string
#  parent_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ClubType < ActiveRecord::Base

  has_many :clubs
  belongs_to :parent, class_name: 'ClubType', foreign_key: 'parent_id'

end
