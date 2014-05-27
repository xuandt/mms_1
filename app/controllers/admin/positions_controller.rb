class Admin::PositionsController < ApplicationController
  def show
	@position = Position.find params[:id]
  end
  def new
  	@position = Position.new
  end
  def create
  	@position = Position.new position_params
  	if @position.save 
  		flash[:success] = "Create successfully"
  		redirect_to admin_positions_path
  	end
  end
  def index
  	@positions = Position.paginate page: params[:page]
    @positions = Position.order(:name)
    respond_to do |format|
    format.html
    format.csv { send_data @positions.to_csv }
    end
  end
  def edit
  	@position = Position.find params[:id]
  end
  def update
  	@position = Position.find params[:id]
  	if @position.update_attributes position_params
  		flash[:success] = "Update"
  		redirect_to admin_position_path
  	else 
  		render 'edit'
    end
  end
  def destroy
  	@position = Position.find(params[:id]).destroy
  	flash[:success] = "Position deleted"
    redirect_to admin_positions_path
  end
  def import
    Position.import(params[:file])
    redirect_to admin_positions_path, notice: "Positions imported."
  end
  private
    def position_params
      params.require(:position).permit(:name, :short_name)
    end
end