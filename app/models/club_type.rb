# == Schema Information
#
# Table name: club_types
#
#  id         :integer          not null, primary key
#  club_id    :integer
#  c_type_id  :integer
#  subtype    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ClubType < ActiveRecord::Base
end
