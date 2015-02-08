module EventSearch
  extend ActiveSupport::Concern

  module ClassMethods

    def search_by_type(type)
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

    def search_by_name(name)
      events = Event.where('name LIKE ?', "%#{name}%")
      if events.any?
        message = "Результаты поиска событий по запросу \"#{name}\""
      else
        message = 'Нет таких событий'
      end
      map_title = 'Найденные события'
      { events: events, message: message, map_title: map_title }
    end

    def search_not_started
      { events: Event.not_started, message: 'Все события', map_title: 'Все события' }
    end

  end

end