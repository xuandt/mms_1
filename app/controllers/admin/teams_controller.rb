class Admin::TeamsController < ApplicationController
   def show
    @team = Team.find params[:id]
  end
  def index
      @teams = Team.paginate page: params[:page]
      @teams = Team.order(:name)
      respond_to do |format|
      format.html
      format.csv { send_data @teams.to_csv }
    end
  end
  def new
    @team = Team.new
  end
  def create
    @team = Team.new team_params
    if @team.save 
      flash[:success] = "Create successfully"
      redirect_to admin_teams_path
    end
  end
  def edit
    @team = Team.find params[:id]
  end
  def update
    @team= Team.find params[:id]
    if @team.update_attributes team_params
      flash[:success] = "Update"
      redirect_to admin_team_path
    else 
      render 'edit'
    end
  end
  def destroy
    @team = Team.find(params[:id]).destroy
    flash[:success] = "Team deleted"
    redirect_to admin_teams_path
  end
  def import
    Team.import(params[:file])
    redirect_to admin_teams_path, notice: "Teams imported."
  end
  private
    def team_params
      params.require(:team).permit(:name, :description, :teamleader)
    end
end
