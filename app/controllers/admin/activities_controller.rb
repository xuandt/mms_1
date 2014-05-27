class Admin::ActivitiesController < ApplicationController
  def new
  end

  def index
    @activities = Activity.paginate page: params[:page]
  end

  def show
    @activity = Activity.find params[:id]
  end

  def destroy
    Activity.find(params[:id]).destroy
    flash[:success] = "Activity deleted."
    redirect_to admin_activities_path
  end
end
