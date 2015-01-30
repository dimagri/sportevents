# == Schema Information
#
# Table name: event_types
#
#  id         :integer          not null, primary key
#  name       :string
#  parent_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class EventType < ActiveRecord::Base

  has_many :events
  belongs_to :parent, class_name: 'EventType', foreign_key: 'parent_id'

  validates :name, presence: true

end
