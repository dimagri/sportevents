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

  # def self.search_by_type(type)
  #   clubs = Club.where(type: type).confirmed
  #   category = ClubType.find(type)
  #   if clubs.any?
  #     message = "Результаты поиска секций по категории \"#{category.name}\""
  #   else
  #     message = 'Пока нет секций в этой категории'
  #   end
  #   map_title = "Секции с категорией \"#{category.name}\""
  #   { clubs: clubs, message: message, map_title: map_title }
  # end
  #
  # def self.search_by_name(name)
  #   clubs = Club.where('name LIKE ?', "%#{name}%")
  #   if clubs.any?
  #     message = "Результаты поиска секций по названию \"#{name}\""
  #   else
  #     message = 'Нет таких секций'
  #   end
  #   map_title = 'Найденные секции'
  #   { clubs: clubs, message: message, map_title: map_title }
  # end
  #
  # def self.search_confirmed
  #   { clubs: Club.confirmed, message: 'Все секции', map_title: 'Все секции' }
  # end

end
