# == Schema Information
#
# Table name: c_types
#
#  id         :integer          not null, primary key
#  type       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CType < ActiveRecord::Base
end
