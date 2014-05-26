class Admin::TeamsController < ApplicationController
   def show
    @team = Team.find params[:id]
  end
  def index
      @teams = Team.paginate page: params[:page]
  end
  def new
    @team = Team.new
  end
  def create
    @team = Team.new team_params
    if @team.save
      flash[:success] = "Create a new team success!"
      Activity.create( time: Time.now, action: "Create Team", description: @team.name)
      redirect_to admin_teams_path
    else
      render 'new'
    end
  end
  def edit
    @team = Team.find params[:id]
  end
  def update
    @team = Team.find params[:id]
    if @team.update_attributes(team_params)
      flash[:success] = "Successful! Team updated."
      Activity.create( time: Time.now, action: "Update Team", description: @team.name)
      redirect_to admin_team_path
    else
      flash[:faild] = "Edit faild"
      render 'edit'
    end
  end
  def destroy
    team = Team.find (params[:id])
    Activity.create( time: Time.now, action: "Delete Team", description: team.name)
    team.destroy
    flash[:success] = "Team deleted."

    redirect_to admin_teams_path
  end

  private
    def team_params
      params.require(:team).permit(:name, :description, :teamleader)
    end
end
