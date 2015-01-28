class ClubsController < ApplicationController

  before_action :set_club, only: [ :show, :edit, :update ]
  before_action :create_club_location, only: [ :create, :update ]
  before_action :check_current_user, only: :new
  before_action :check_club_author, only: :edit

  def index
    @clubs = Club.all
  end

  def new
    @club = Club.new
  end

  def create
    @club = Club.new(club_params)
    @club.author = current_user
    @club.location = @location
    respond_to do |format|
      if @club.save
        format.html { redirect_to @club, notice: 'Секция была добавлена' }
      else
        format.html { render :new }
      end
    end
  end

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @club.update_attributes(club_params) && @club.update_attributes(location: @location)
        format.html { redirect_to @club, notice: 'Секция была изменена' }
      else
        format.html { render :edit }
      end
    end
  end

  private

  def set_club
    @club = Club.find(params[:id])
  end

  def club_params
    params.require(:club).permit(:name, :club_type_id, :description, :price, :phone)
  end

  def create_club_location
    if params[:location].nil?
      redirect_to :back, alert: 'Поставьте метку на карте'
      return
    end
    loc_params = params[:location].split(' ')
    @location = Location.create(latitude: loc_params[0], longitude: loc_params[1])
  end

  def check_current_user
    redirect_to root_path, alert: 'Сначала зарегистрируйтесь' unless current_user.present?
  end

  def check_club_author
    unless @club.author == current_user || current_user.admin?
      redirect_to @club, alert: 'Вы не можете внести изменения в эту секцию'
    end
  end

end
