class EmployeesController < ApplicationController
	
	before_action :restrict_access, except: [:edit, :update]
	before_action :find_employee, only: [:show, :edit, :update, :destroy]
	before_action :all_employees_paginated, only: [:new, :create]

	def index
	  filter = params[:filter]
	  status = params[:status]
	  
	  if filter == 'true'
  	  case status
  	  when 'active'
  	    @employees = Employee.active.joins(join_table).order(sort_column + ' ' + sort_direction)
  	  when 'inactive'
  	    @employees = Employee.inactive.joins(join_table).order(sort_column + ' ' + sort_direction)
  	  when 'admin'
  	    @employees = Employee.admin.joins(join_table).order(sort_column + ' ' + sort_direction)
  	  else
  	    @employees = Employee.all.joins(join_table).order(sort_column + ' ' + sort_direction)
  	  end
  	else
  	 case status
      when 'active'
        @employees = Employee.active.joins(join_table).order(sort_column + ' ' + sort_direction).paginate(:page => params[:page])
      when 'inactive'
        @employees = Employee.inactive.joins(join_table).order(sort_column + ' ' + sort_direction).paginate(:page => params[:page])
      when 'admin'
        @employees = Employee.admin.joins(join_table).order(sort_column + ' ' + sort_direction).paginate(:page => params[:page])
      else
        all_employees_paginated
      end
  	end
	end
	
	def show
    redirect_to new_employee_path
  end

	def new
		@employee = Employee.new
	end

	def edit
	  if current_employee.admin? || @employee.id == current_employee.id
	    render 'edit'
	  else
	    flash[:danger] = "You are not authorized to edit that employee!"
	    redirect_to edit_employee_path(current_employee)    
	  end
	end

	def create
		@employee = Employee.new(employee_params_admin)

		if @employee.save
			flash[:success] = "Employee created!"
			redirect_to new_employee_path
		else
		  flash.now[:danger] = "There was a problem adding the employee."
			render 'new'
		end
	end

	def update
	  # This could probably be refactored
	  if current_employee.admin?
	    if @employee.update_attributes(employee_params_admin)
        flash[:success] = "Employee profile updated!"
        redirect_to new_employee_path
      else
        flash.now[:danger] = "There was a problem updating the employee."
        render 'edit'
      end
	  else
	    if @employee.update_attributes(employee_params_restricted)
        flash[:success] = "Employee profile updated!"
        redirect_to tickets_my_path
      else
        flash.now[:danger] = "There was a problem updating the employee."
        render 'edit'
      end
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

		def all_employees_paginated
		  @employees = Employee.all.joins(join_table).order(sort_column + ' ' + sort_direction).paginate(:page => params[:page])
	  end

		def employee_params_admin
			params.require(:employee).permit(:first_name, :last_name, :user_name, :password, :password_confirmation, :office_id, :admin, :active)
		end
		
		def employee_params_restricted
      params.require(:employee).permit(:first_name, :last_name, :user_name, :password, :password_confirmation, :office_id)
    end

end