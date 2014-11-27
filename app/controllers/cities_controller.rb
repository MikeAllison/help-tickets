class CitiesController < ApplicationController

  before_action :restrict_access
  before_action :find_city, only: [:show, :edit, :update, :destroy]
  before_action :all_cities, only: [:index, :new, :create]
  
  def index
  end
  
  def show
    redirect_to new_city_path
  end

  def new
    @city = City.new
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

    def all_cities
      @cities = City.joins(join_table).order(sort_column + ' ' + sort_direction).paginate(:page => params[:page])
    end

    
    def city_params
      params.require(:city).permit(:name, :state_id)
    end
    
end
