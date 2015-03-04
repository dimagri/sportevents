# == Schema Information
#
# Table name: events
#
#  id            :integer          not null, primary key
#  event_type_id :integer
#  user_id       :integer
#  name          :string
#  description   :text
#  phone         :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  begins_at     :datetime
#

class Event < ActiveRecord::Base

  include SportObject, EventSearch

  acts_as_readable :on => :created_at
  paginates_per 15

  belongs_to :type, class_name: 'EventType', foreign_key: 'event_type_id'

  validates :event_type_id, presence: true
  validates :begins_at, presence: true, date: {
                          after: Proc.new { Time.now },
                          before: Proc.new { Time.now + 1.year },
                          message: 'содержит неверное значение'
                        }

  scope :not_started, ->{ where('begins_at > ?', Time.now.to_datetime) }
  scope :started, ->{ where('begins_at < ?', Time.now.to_datetime) }

  def self.add(event_params, current_user, location)
    Event.new(event_params) do |c|
      c.author = current_user
      c.location = location
    end
  end

  def to_param
    "#{id}-#{name.parameterize}"
  end
end
