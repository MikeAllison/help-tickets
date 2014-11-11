class OfficesController < ApplicationController
	
	before_action :find_office, only: [:edit, :update, :destroy]
	
	def index
		@offices = Office.all
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
			redirect_to offices_path
		else
			render 'new'
		end
	end

	def update
		if @office.update_attributes(office_params)
			flash[:success] = "Office information updated!"
			redirect_to offices_path
		else
			render 'edit'
		end
	end

	def destroy
		@office.destroy
	end

	private

		def find_office
			@office = Office.find(params[:id])
		end

		def office_params
			params.require(:office).permit(:name)
		end

end