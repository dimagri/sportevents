class ClubsController < ApplicationController

  before_action :set_club, only: [ :show ]
  before_action :create_club_location, only: :create
  before_action :check_user, only: :new

  def index
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

  def check_user
    redirect_to root_path, alert: 'Сначала зарегистрируйтесь' unless current_user.present?
  end

end
