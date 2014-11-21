class CitiesController < ApplicationController
  
  before_action :find_city, only: [:show, :edit, :update, :destroy]
  
  def index
    @cities = City.joins(join_table).order(sort_by + ' ' + sort_direction).paginate(:page => params[:page])
  end

  def new
    @city = City.new
    @cities = City.joins(join_table).order(sort_by + ' ' + sort_direction).paginate(:page => params[:page])
  end

  def edit
  end

  def create
    @city = City.new(city_params)
    
    if @city.save
      flash[:success] = "City created!"
      redirect_to new_city_path
    else
      flash.now[:danger] = "There was a problem adding the city."
      render 'new'
    end
  end

  def update
    if @city.update_attributes(city_params)
      flash[:success] = "City updated!"
      redirect_to new_city_path
    else
      flash.now[:danger] = "There was a problem updating the city."
      render 'edit'
    end
  end

  def destroy
    @city.destroy
    flash[:success] = "City deleted!"
    redirect_to new_city_path
  end

  private

    def find_city
      @city = City.find(params[:id])
    end
    
    def city_params
      params.require(:city).permit(:name, :state_id)
    end
    
end
