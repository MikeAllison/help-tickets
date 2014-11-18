class OfficesController < ApplicationController
	
	before_action :find_office, only: [:show, :edit, :update, :destroy]
	
	def index
		@offices = Office.order(:name).paginate(:page => params[:page])
	end

	def new
	  @office = Office.new
	  @offices = Office.order(:name).paginate(:page => params[:page])
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

		def office_params
			params.require(:office).permit(:name)
		end

end