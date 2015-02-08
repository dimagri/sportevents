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

  belongs_to :type, class_name: 'EventType', foreign_key: 'event_type_id'
  belongs_to :author, class_name: 'User', foreign_key: 'user_id'
  has_one :location, as: :locationable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy

  validates :user_id, :event_type_id, :location, presence: true
  validates :name, presence: true, length: { minimum: 5 }
  validates :description, presence: true, length: { minimum: 20 }
  validates :phone, presence: true
  validates :begins_at, presence: true, date: {
                          after: Proc.new { Time.now },
                          before: Proc.new { Time.now + 1.year },
                          message: 'содержит неверное значение'
                      }

  scope :not_started, ->{ where('begins_at > ?', Time.now.to_datetime) }
  scope :finished, ->{ where('begins_at < ?', Time.now.to_datetime) }

  def self.add(event_params, current_user, location)
    Event.new(event_params) do |c|
      c.author = current_user
      c.location = location
    end
  end

  def self.search_by_type(type)
    events = Event.where(type: type)
    category = EventType.find(type)
    if events.any?
      message = "Результаты поиска событий по категории \"#{category.name}\""
    else
      message = 'Пока нет секций в этой категории'
    end
    map_title = "События с категорией \"#{category.name}\""
    { events: events, message: message, map_title: map_title }
  end

  def self.search_by_name(name)
    events = Event.where('name LIKE ?', "%#{name}%")
    if events.any?
      message = "Результаты поиска событий по запросу \"#{name}\""
    else
      message = 'Нет таких событий'
    end
    map_title = 'Найденные события'
    { events: events, message: message, map_title: map_title }
  end

  def self.search_not_started
    { events: Event.not_started, message: 'Все события', map_title: 'Все события' }
  end
end
