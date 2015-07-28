class CitiesController < ApplicationController

  before_action :restrict_access
  before_action :find_city, only: [:show, :edit, :update, :destroy]
  before_action :find_all_cities, only: [:index, :new, :create]

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
      if @city.errors.any?
        flash.now[:danger] = 'City ' + @city.errors.full_messages[0].to_s
      else
        flash.now[:danger] = "There was a problem adding the city."
      end
      render 'new'
    end
  end

  def update
    if @city.update(city_params)
      flash[:success] = "City updated!"
      redirect_to new_city_path
    else
      flash.now[:danger] = "There was a problem updating the city."
      render 'edit'
    end
  end

  def hide
    @city.update(hidden: true)
    flash[:success] = "City hidden!"
    redirect_to new_city_path
  end

  private

    def find_city
      @city = City.find_by!(slug: params[:id])
    end

    def find_all_cities
      @cities = City.not_hidden
      @cities = apply_joins_and_order(@cities)
      @cities = apply_pagination(@cities)
    end

    def city_params
      params.require(:city).permit(:name, :state_id, :hidden)
    end

end
