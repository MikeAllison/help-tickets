class OfficesController < ApplicationController
	
	before_filter :restrict_access
	before_action :find_office, only: [:show, :edit, :update, :destroy]
	before_action :all_offices, only: [:index, :new, :create]
	
	def index
	end

	def new
	  @office = Office.new
	end

	def edit
	end

	def create
		@office = Office.new(office_params)

		if @office.save
			flash[:success] = "Office created!"
			redirect_to new_office_path
		else
      flash.now[:danger] = "There was a problem adding the office."
			render 'new'
		end
	end

	def update
		if @office.update_attributes(office_params)
			flash[:success] = "Office information updated!"
			redirect_to new_office_path
		else
      flash.now[:danger] = "There was a problem updating the office."
			render 'edit'
		end
	end

	def destroy
		@office.destroy
		flash[:success] = "Office deleted!"
		redirect_to new_office_path
	end

	private

		def find_office
			@office = Office.find(params[:id])
		end

		def all_offices
			@offices = Office.joins(join_table).order(sort_by + ' ' + sort_direction).paginate(:page => params[:page])
		end

		def office_params
			params.require(:office).permit(:name)
		end

end