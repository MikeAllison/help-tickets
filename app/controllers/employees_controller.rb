class EmployeesController < ApplicationController
	
	before_action :restrict_access
	before_action :find_employee, only: [:show, :edit, :update, :destroy]
	before_action :all_employees, only: [:index, :new, :create]

	def index
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
			redirect_to new_employee_path
		else
		  flash.now[:danger] = "There was a problem adding the employee."
			render 'new'
		end
	end

	def update
		if @employee.update_attributes(employee_params)
			flash[:success] = "Employee profile updated!"
			redirect_to new_employee_path
		else
		  flash.now[:danger] = "There was a problem updating the employee."
			render 'edit'
		end
	end

	def destroy
		@employee.destroy
		flash[:success] = "Employee deleted!"
		redirect_to new_employee_path
	end

	private

		def find_employee
			@employee = Employee.find(params[:id])
		end

		def all_employees
			@employees = Employee.joins(join_table).order(sort_by + ' ' + sort_direction).paginate(:page => params[:page])
		end

		def employee_params
			params.require(:employee).permit(:first_name, :last_name, :user_name, :password, :password_confirmation, :office_id, :admin)
		end

end