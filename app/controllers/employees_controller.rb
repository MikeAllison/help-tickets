class EmployeesController < ApplicationController
	
	before_action :find_employee, only: [:edit, :update, :destroy]

	def index
		@employees = Employee.all
	end

	def new
		@employee = Employee.new
	end

	def edit
	end

	def create
		@employee = Employee.new(employee_params)

		if @employee.save
			flash[:success] = "Employee created!"
			redirect_to employees_path
		else
			render 'new'
		end
	end

	def update
		if @employee.update_attributes(employee_params)
			flash[:success] = "Employee profile updated!"
			redirect_to employees_path
		else
			render 'edit'
		end
	end

	def destroy
		@employee.destroy
	end

	private

		def find_employee
			@employee = Employee.find(params[:id])
		end

		def employee_params
			params.require(:employee).permit(:first_name, :last_name, :user_name, :password, :password_confirmation, :office_id, :admin)
		end

end