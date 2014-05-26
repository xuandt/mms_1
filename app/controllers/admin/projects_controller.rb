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
  end
  def new
    @project = Project.new
  end
  def create
    @project = Project.new project_params
    if @project.save
      Activity.create( time: Time.now, action: " Create Project",
                        description: @project.name)
      redirect_to admin_projects_path
    else
      render 'new'
    end
  end
  def edit
    @project = Project.find params[:id]
  end
  def update
     @project = Project.find params[:id]
    if @project.update_attributes project_params
      Activity.create( time: Time.now, action: " Delete Project",
                        description: @project.name)
      flash[:success] = "Update done!"
      redirect_to admin_project_path
    else 
      render 'edit'
    end
  end
  def destroy
    project= Project.find(params[:id])
    Activity.create( time: Time.now, action: " Delete Project", description: project.name)
    project.destroy
    flash[:success] = "project deleted."
    redirect_to admin_projects_path
  end

  private
    def project_params
      params.require(:project).permit(:name, :shortname, :start_date, :end_date, :team_id, :project_leader)
    end
end