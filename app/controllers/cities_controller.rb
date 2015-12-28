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
      respond_to do |format|
        format.html { city_saved_redirect }
      end
		elsif @city.save
      flash[:success] = 'City added!'
      respond_to do |format|
        format.html { city_saved_redirect }
      end
		else
      @city.errors.any? ? flash.now[:danger] = 'Please fix the following errors.' : 'There was a problem adding the city.'
      respond_to do |format|
        format.html { render 'new' }
        format.js { render 'append_errors' }
      end
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

  def city_saved_redirect
    if params[:submitted_from] == 'add_city_modal' # If form submitted from #addCityModal in 'offices/new'
      redirect_to new_office_path
    else # If form submitted from 'cities/new' (the ususal way)
      redirect_to new_city_path
    end
  end

end
