class ClubsController < ApplicationController

  include Locationable

  before_action :set_club, only: [ :show, :edit, :update ]
  before_action :check_current_user, only: :new
  before_action :check_club_author, only: :edit

  def index
    if params[:search_by_type].present?
      search_hash = Club.search_by_type(params[:search_by_type])
    elsif params[:search_by_name].present?
      search_hash = Club.search_by_name(params[:search_by_name])
    else
      search_hash = Club.search_confirmed
    end
    @clubs, @message, @map_title = search_hash[:clubs], search_hash[:message], search_hash[:map_title]
    @locationables = @clubs
    @club_types = ClubType.all
  end

  def new
    @club = Club.new
  end

  def create
    @club = Club.add(club_params, current_user, @location)
    respond_to do |format|
      if @club.save
        format.html { redirect_to @club, notice: 'Секция будет добавлена после прохождения модерации' }
      else
        format.html { render :new }
      end
    end
  end

  def show
    @locationable = @club
    @commentable = @club
    @comments = @commentable.comments.ordered
    @comment = Comment.new
  end

  def edit
    @locationable = @club
  end

  def update
    respond_to do |format|
      if @club.update_attributes(club_params)
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
    c_params = params.require(:club).permit(:name, :club_type_id, :description, :price, :phone)
    c_params[:location] = @location
    c_params
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
