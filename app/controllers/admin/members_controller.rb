class Admin::MembersController < ApplicationController
  include SessionsHelper
  before_action :signed_in_member, only: [:index, :edit, :update, :destroy]
  before_action :admin_member,     only: :destroy

  def show
    @member = Member.find params[:id]
  end
  def new
    @member = Member.new
  end
  def create
    @member = Member.new member_params
    if @member.save
       flash[:success] = "Signup successfully"
       redirect_to @member
    end
  end
  def index
    @members = Member.all
  end
  def edit
    @member = Member.find params[:id]
  end
  def update
  	@member = Member.find params[:id]
    if @member.update_attributes member_params
      flash[:success] = "Profile updated"
      redirect_to @member
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
    def signed_in_member
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end
    def admin_member
      redirect_to(root_url) unless current_member.admin?
    end
    def member_params
      params.require(:member).permit(:name, :email, :password, :password_confirmation)
    end
  end