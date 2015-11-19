class CitiesController < ApplicationController

  before_action :restrict_to_technicians
  before_action :find_city, only: [:edit, :update, :hide]
  before_action :find_all_cities, only: [:index, :new, :create]

  def index
  end

  def new
    @city = City.new
  end

  def create
    @city = City.new(city_params)

    if City.hidden.exists?(["name LIKE ? AND state_id = ?", @city.name, @city.state_id])
			hidden_city = City.hidden.where("name LIKE ? and state_id = ?", @city.name, @city.state_id).first
			hidden_city.unhide
      flash[:success] = 'This city had already existed but has now been unhidden!'
      redirect_to new_city_path
		elsif @city.save
      flash[:success] = 'City added!'
      redirect_to new_city_path
		else
      @city.errors.any? ? flash.now[:danger] = 'Please fix the following errors.' : 'There was a problem adding the city.'
      render 'new'
		end
  end

  def edit
  end

  def update
    if @city.update(city_params)
      flash[:success] = 'City updated!'
      redirect_to new_city_path
    else
      @city.errors.any? ? flash.now[:danger] = 'Please fix the following errors.' : 'There was a problem updating the city.'
      render 'edit'
    end
  end

  def hide
    @city.update(hidden: true)
    flash[:success] = 'City hidden!'
    redirect_to new_city_path
  end

  private

  def find_city
    @city = City.find_by!(slug: params[:id])
  end

  def find_all_cities
    @cities = City.not_hidden
  end

  def city_params
    params.require(:city).permit(:name, :state_id, :hidden)
  end

end
