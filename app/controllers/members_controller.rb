class MembersController < ApplicationController
  before_action :signed_in_member, only: [:index, :edit, :update, :destroy]
  
  def show
    @member = Member.find params[:id]
  end
  def new
    @member = Member.new
  end
  def create
    @member = Member.new(member_params)
    if @member.save
       flash[:success] = "Signup successfully"
       redirect_to @member
    end
  end
  
  private
    def signed_in_member
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end
    def member_params
      params.require(:member).permit(:name, :email, :password, :password_confirmation)
    end
end