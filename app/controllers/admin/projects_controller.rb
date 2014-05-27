class Admin::ProjectsController < ApplicationController
  def show
    @project = Project.find params[:id]
  end
  def index
    if params[:team_id]
      team = Team.find params[:team_id]
      @projects = team.projects.paginate page: params[:page]
    else
      @projects = Project.paginate page: params[:page]
    end
    @projects = Project.order(:name)
    respond_to do |format|
    format.html
    format.csv { send_data @projects.to_csv }
    end
  end
  def new
    @project = Project.new
  end
  def create
    @project = Project.new project_params
    if @project.save 
      flash[:success] = "Create successfully"
      redirect_to admin_projects_path
    end
  end
  def edit
    @project = Project.find params[:id]
  end
  def update
    @project= Project.find params[:id]
    if @project.update_attributes project_params
      flash[:success] = "Update"
      redirect_to admin_project_path
    else 
      render 'edit'
    end
  end
  def destroy
    @project = Project.find(params[:id]).destroy
    flash[:success] = "Project deleted"
    redirect_to admin_projects_path
  end
  def import
    Project.import(params[:file])
    redirect_to admin_projects_path, notice: "Projects imported."
  end
  private
    def project_params
      params.require(:project).permit(:name, :shortname, :start_date, :end_date, :team_id, :project_leader)
    end
end