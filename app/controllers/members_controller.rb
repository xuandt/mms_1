class MembersController < ApplicationController
  before_action :signed_in_member, only: [:index, :edit, :update, :destroy]
  before_action :set_member, only: [:show, :edit, :update, :destroy]
  before_action :correct_member,   only: [:edit, :update]
  before_action :admin_member,     only: :destroy

  def index
    @members = Member.all
  end

  def show
  end

  def new
    @member = Member.new
  end

  def edit
  end

  def create
    @member = Member.new(member_params)

    respond_to do |format|
      if @member.save
        format.html { redirect_to @member, notice: 'Member was successfully created.' }
        format.json { render action: 'show', status: :created, location: @member }
      else
        format.html { render action: 'new' }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @member.update(member_params)
        format.html { redirect_to @member, notice: 'Member was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @member.destroy
    respond_to do |format|
      format.html { redirect_to members_url }
      format.json { head :no_content }
    end
  end

  private
    def set_member
      @member = Member.find(params[:id])
    end
    def signed_in_member
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end
    def correct_member
      @user = Member.find params[:id]
      redirect_to(root_url) unless current_member?(@member)
    end
    def admin_member
      redirect_to(root_url) unless current_member.admin?
    end

    def member_params
      params.require(:member).permit(:name, :email, :birthday, :team_id, :position_id, :project_id)
    end
end