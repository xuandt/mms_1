class Admin::MembersController < ApplicationController
  include SessionsHelper


  def show
    @member = Member.find params[:id]
  end
  def new
    @member = Member.new
    @projects = Project.all
    @projects.each do |project|
      @member.member_projects.build project_id: project.id
    end
    @skills = Skill.all
    @skills.each do |skill|
      @member.member_skills.build skill_id: skill.id
    end
  end
  def create
    @member = Member.new member_params
    if @member.save
      Activity.create( time: Time.now, action: "Create Member",
                                member: @member.id, description: @member.name)

      flash[:success] = "Create Successful!"
      redirect_to admin_member_path
    else
      flash[:faild] = "fail"
      render 'new'
    end
  end
  def index
    if params[:team_id]
      team = Team.find params[:team_id]
      @members = team.members.paginate page: params[:page]
    else
      @members = Member.paginate page: params[:page]
    end
  end
  def edit
    @member = Member.find params[:id]
    @members = Member.paginate page: params[:page]
  end
  def update
    @member = Member.find params[:id]
    if @member.update_attributes member_params
      flash[:success] = "Successful! Profile updated."
      Activity.create( time: Time.now, action: "Update Member",
                                member: @member.id, description: @member.name)
      redirect_to admin_member_path
    else
      flash[:faild] = "Edit faild"
      render 'edit'
    end
  end
  def destroy
    @member = Member.find(params[:id])
    Activity.create( time: Time.now, action: "Deleted Member",
                                member: @member.id, description: @member.name)
    @member.destroy
   
    flash[:success] = "Member deleted."
    redirect_to admin_members_url
  end
  private
    def member_params
      params.require(:member).permit(:name, :email, :password, :password_confirmation, "project_ids" => [], member_skills_attributes: [:skill_id, :level, :used_years])
    end
  end