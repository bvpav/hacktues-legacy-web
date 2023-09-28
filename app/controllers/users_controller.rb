require 'rqrcode'

class UsersController < ApplicationController

  def index
    @users = User.paginate(page: params[:page]).order('name ASC')
    @participant_count = User.all.count - User.where(admin: true).size
    @checked_count = User.where(current_presence: true).count
  end

  def check
    @user = User.find(params[:id])
    @day = Date.current.inspect.split(' ').second.to_i
    # change to @day == 9 before start of hackathon
    if (@day == 9)
      @user.update(day1: true)
    elsif (@day == 10)
      @user.update(day2: true)
    elsif (@day == 11)
      @user.update(day3: true)
    end
    @user.update(current_presence: false) if @user.current_presence == nil
    @user.update(current_presence: !@user.current_presence)
    flash[:success] = "Успешно чекиране на участник."
    redirect_to user_path
  end

  def declaration
    @user = User.find(params[:id])
    @user.update(declaration: false) if @user.declaration == nil
    @user.update(declaration: !@user.declaration)
    flash[:success] = "Успешно отбелязване на декларация."
    redirect_to user_path
  end

  def show
    @user = User.find(params[:id])
    if @user == current_user && @user.team_id == nil
      @invites = Invite.where(to_id: @user.id)
      if @invites.any?
        @invites.each do |invite|
          @from_user = User.find(invite.from_id)
          @from_team = Team.find(@from_user.team_id)
          flash.now[:info] = "Покана от #{@from_user.name} за #{@from_team.name}
          <a href='/invites/accept?from_id=#{invite.from_id}&to_id=#{invite.to_id}'>
            <span class='label label-success'>Приеми</span>
          </a>
          <a href='/invites/decline?from_id=#{invite.from_id}&to_id=#{invite.to_id}'>
            <span class='label label-danger'>Откажи</span>
          </a>".html_safe
        end
      end
    end
    @current_user_team = Team.where(captain_id: current_user.id)
    get_team
    @invite = Invite.where(from_id: current_user.id, to_id: params[:id])
    @barcode = RQRCode::QRCode.new(user_url + "/check", size: 8, level: :h)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = "Провери си пощата за линк за активация."
      redirect_to root_url
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Успешно обновяване на профила."
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "Участник изтрит."
    redirect_to users_url
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation,
                                   :number, :klas, :section,
                                   :day1, :day2, :day3,
                                   :current_presence)
    end

    # Before filters

    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Влез в профила си."
        redirect_to login_url
      end
    end

    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

    def get_team
      begin
        @team = Team.find(@user.team_id)
      rescue ActiveRecord::RecordNotFound
        @team = false
        return
      end
    end
end
