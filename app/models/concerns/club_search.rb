module ClubSearch
  extend ActiveSupport::Concern

  module ClassMethods

    def search_by_type(type)
      clubs = Club.where(type: type).confirmed
      category = ClubType.find(type)
      if clubs.any?
        message = "Результаты поиска секций по категории \"#{category.name}\""
      else
        message = 'Пока нет секций в этой категории'
      end
      map_title = "Секции с категорией \"#{category.name}\""
      { clubs: clubs, message: message, map_title: map_title }
    end

    def search_by_name(name)
      clubs = Club.where('name LIKE ?', "%#{name}%")
      if clubs.any?
        message = "Результаты поиска секций по названию \"#{name}\""
      else
        message = 'Нет таких секций'
      end
      map_title = 'Найденные секции'
      { clubs: clubs, message: message, map_title: map_title }
    end

    def search_confirmed
      { clubs: Club.confirmed, message: 'Все секции', map_title: 'Все секции' }
    end

  end

end