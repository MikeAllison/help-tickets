class OfficesController < ApplicationController
	
	before_action :restrict_access
	before_action :find_office, only: [:edit, :update, :destroy]
	before_action :all_offices_paginated, only: [:new, :create]
	
	def index
	  filter = params[:filter]
	  
	  if filter == 'true'
	    @offices = Office.joins(join_table).order(sort_column + ' ' + sort_direction)
	  else
	    all_offices_paginated
	  end
	end
	
	def show
	  redirect_to new_office_path
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

		def all_offices_paginated
			@offices = Office.joins(join_table).order(sort_column + ' ' + sort_direction).paginate(:page => params[:page])
		end

		def office_params
			params.require(:office).permit(:name)
		end

end