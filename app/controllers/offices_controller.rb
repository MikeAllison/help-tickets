class OfficesController < ApplicationController
  before_action :restrict_to_technicians
  before_action :find_office, only: [:edit, :update, :hide]
  before_action :find_all_offices, only: [:index, :new, :create]

  def index
  end

  def new
    @office = Office.new
    @city = City.new
  end

  def create
    @office = Office.new(office_params)
    @city = City.new

    if Office.hidden.exists?(["name LIKE ? AND city_id = ?", @office.name, @office.city_id])
      hidden_office = Office.hidden.where("name LIKE ? and city_id = ?", @office.name, @office.city_id).first
      hidden_office.unhide(@office.active)
      flash[:success] = 'This office had already existed but has now been unhidden!'
      redirect_to new_office_path
    elsif @office.save
      flash[:success] = 'Office added!'
      redirect_to new_office_path
    else
      @office.errors.any? ? flash.now[:danger] = 'Please fix the following errors.' : 'There was a problem adding the office.'
      render 'new'
    end
  end

  def edit
  end

  def update
    if @office.update(office_params)
      flash[:success] = 'Office information updated!'
      redirect_to new_office_path
    else
      @office.errors.any? ? flash.now[:danger] = 'Please fix the following errors.' : 'There was a problem updating the office.'
      render 'edit'
    end
  end

  def hide
    @office.update(hidden: true, active: false)
    flash[:success] = 'Office hidden!'
    redirect_to new_office_path
  end

  private

  def find_office
    @office = Office.find_by!(slug: params[:id])
  end

  def find_all_offices
    @offices = Office.not_hidden
  end

  def office_params
    params.require(:office).permit(:name, :city_id, :active, :hidden)
  end

end
