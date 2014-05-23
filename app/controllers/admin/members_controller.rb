class Admin::MembersController < ApplicationController
  include SessionsHelper
  before_action :admin_member,     only: :destroy

  def show
    @member = Member.find params[:id]
  end
  def new
    @member = Member.new
    @projects = Project.all
    @projects.each do |project|
      @member.member_projects.build project_id: project.id
    end
  end
  def create
    @member = Member.new member_params
    if @member.save
       flash[:success] = "Signup successfully"
       redirect_to admin_member_path
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
      flash[:success] = "Profile updated"
      redirect_to admin_member_path
    else
      render 'edit'
    end
  end
  def destroy
    @member = Member.find(params[:id]).destroy
    flash[:success] = "Member deleted."
    redirect_to admin_members_url
  end
  private
    def admin_member
      redirect_to(root_url) unless current_member.admin?
    end
    def member_params
      params.require(:member).permit(:name, :email, :password, :password_confirmation, "project_ids" => [])
    end
  end