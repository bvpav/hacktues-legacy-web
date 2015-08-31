class TeamsController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  # before_action :correct_user,     only: :destroy

  def index
    @teams = Team.paginate(page: params[:page])
  end

  def show
    @team = Team.find(params[:id])
    @captain = User.find(@team.captain_id)
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)
    @team.update(captain_id: session[:user_id])
    User.find(@team.captain_id).update(team_id: @team.id)
    if @team.save
      flash[:success] = "Успешно създаден отбор."
      redirect_to "/teams/#{@team.id}"
    else
      render 'new'
    end
  end

  def destroy
    Team.find(params[:id]).destroy
    flash[:success] = "Отбор изтрит."
    redirect_to teams_url
  end

  private

    def team_params
      params.require(:team).permit(:name, :project_name, :project_desc,
                                   :captain_id)
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
    # def correct_user
    #   @user = User.find(params[:id])
    #   redirect_to(root_url) unless @user.id == current_team.captain_id
    # end

    # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
