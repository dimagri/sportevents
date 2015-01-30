# == Schema Information
#
# Table name: events
#
#  id            :integer          not null, primary key
#  event_type_id :integer
#  user_id       :integer
#  name          :string
#  description   :text
#  date          :string
#  phone         :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Event < ActiveRecord::Base

  belongs_to :type, class_name: 'EventType', foreign_key: 'event_type_id'
  belongs_to :author, class_name: 'User', foreign_key: 'user_id'
  has_one :location

  validates :user_id, :event_type_id, presence: true
  validates :name, presence: true, length: { minimum: 5 }
  validates :description, presence: true, length: { minimum: 20 }
  validates :phone, :begins_at, presence: true

  scope :search_by_type, ->(type) { where(type: type) }
  scope :search_by_name, ->(name) { where('name LIKE ?', "%#{name}%") }
end