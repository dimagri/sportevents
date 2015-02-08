class EventsController < ApplicationController

  include Locationable

  before_action :set_event, only: [ :show, :edit, :update ]
  before_action :check_current_user, only: :new
  before_action :check_event_author, only: :edit

  def index
    if params[:search_by_type].present?
      s_hash = Event.search_by_type(params[:search_by_type])
    elsif params[:search_by_name].present?
      s_hash = Event.search_by_name(params[:search_by_name])
    else
      s_hash = Event.search_not_started
    end
    @events, @message, @map_title = s_hash[:events], s_hash[:message], s_hash[:map_title]
    @event_types = EventType.all
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.add(event_params, current_user, @location)
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
    @comments = @commentable.comments.ordered
    @comment = Comment.new
  end

  def edit
  end

  def update
    respond_to do |format|
      if @event.update_attributes(event_params)
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
    e_params = params.require(:event).permit(:name, :event_type_id, :description, :begins_at, :phone)
    e_params[:location] = @location
    e_params
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