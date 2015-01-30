class EventsController < ApplicationController

  before_action :set_event, only: [ :show, :edit, :update ]
  before_action :create_event_location, only: [ :create, :update ]
  before_action :check_current_user, only: :new
  before_action :check_event_author, only: :edit

  def index
    if params[:search_by_type].present?
      @events= Event.search_by_type(params[:search_by_type])
      if @events.any?
        @message = "Результаты поиска событий по категории \"#{@events.first.type.name}\""
        @map_title = "События с категорией \"#{@clubs.first.type.name}\""
      else
        @message = 'Пока нет секций в этой категории'
        @map_title = ''
      end
    elsif params[:search_by_name].present?
      @events = Event.search_by_name(params[:search_by_name])
      if @events.any?
        @message = "Результаты поиска событий по запросу \"#{params[:search_by_name]}\""
      else
        @message = 'Нет таких событий'
      end
      @map_title = 'Найденные события'
    else
      @events = Event.all
      @map_title = 'Все события'
    end

    @event_types = EventType.all
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.author = current_user
    @event.location = @location
    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Событие добавлено' }
      else
        format.html { render :new }
      end
    end
  end

  def show
    @commentable = @event
    @comments = @commentable.comments
    @comment = Comment.new
  end

  def edit
  end

  def update
    respond_to do |format|
      if @event.update_attributes(event_params) && @event.update_attributes(location: @location)
        format.html { redirect_to @event, notice: 'Событие было изменено' }
      else
        format.html { render :edit }
      end
    end
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:name, :event_type_id, :description, :begins_at, :phone)
  end

  def create_event_location
    if params[:location].nil?
      redirect_to new_event_path, alert: 'Поставьте метку на карте'
      return
    end
    loc_params = params[:location].split(' ')
    @location = Location.create(latitude: loc_params[0], longitude: loc_params[1])
  end

  def check_current_user
    redirect_to root_path, alert: 'Сначала зарегистрируйтесь' unless current_user.present?
  end

  def check_event_author
    unless @event.author == current_user || current_user.admin?
      redirect_to @event, alert: 'Вы не можете внести изменения в это событие'
    end
  end

end