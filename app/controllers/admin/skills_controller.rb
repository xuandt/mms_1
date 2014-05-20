class Admin::SkillsController < ApplicationController
  def show
    @skill = Skill.find params[:id]
  end
  def index
      @skills = Skill.paginate page: params[:page]
  end
  def new
    @skill = Skill.new
  end
  def create
    @skill = Skill.new skill_params
    if @skill.save 
      flash[:success] = "Create successfully"
      redirect_to admin_skills_path
    end
  end
  def edit
    @skill = Skill.find params[:id]
  end
  def update
    @skill= Skill.find params[:id]
    if @skill.update_attributes skill_params
      flash[:success] = "Update"
      redirect_to admin_skill_path
    else 
      render 'edit'
    end
  end
  def destroy
    @skill = Skill.find(params[:id]).destroy
    flash[:success] = "Skill deleted"
    redirect_to admin_skills_path
  end

  private
    def skill_params
      params.require(:skill).permit(:name, :member_id, :level, :used_years)
    end
end
