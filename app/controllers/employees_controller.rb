class EmployeesController < ApplicationController

	before_action :restrict_to_admins, except: [:edit, :update]
	before_action :find_employee, only: [:edit, :update, :hide, :assigned_tickets]
	before_action :find_all_employees, only: [:new, :create]

	def index
	  case params[:status]
	  when 'active'
	    @employees = Employee.active.not_hidden
	  when 'inactive'
	    @employees = Employee.inactive.not_hidden
	  when 'admin'
	    @employees = Employee.admin.not_hidden
	  else
	    @employees = Employee.not_hidden
	  end

	  @employees = apply_joins_and_order(@employees)
	  @employees = apply_pagination(@employees)
	end

	def new
		@employee = Employee.new
	end

	def edit
	  if current_employee.admin? || @employee.id == current_employee.id
	    render 'edit'
	  else
	    flash[:danger] = 'You are not authorized to edit that employee!'
	    redirect_to edit_employee_path(current_employee)
	  end
	end

	def create
		@employee = Employee.new(employee_params_admin)

		if @employee.save
			flash[:success] = 'Employee created!'
			redirect_to new_employee_path
		else
		  flash.now[:danger] = 'There was a problem adding the employee.'
			render 'new'
		end
	end

	def update
	  # This could probably be refactored
	  if current_employee.admin?
	    if @employee.update(employee_params_admin)
        flash[:success] = 'Employee profile updated!'
        redirect_to new_employee_path
      else
        flash.now[:danger] = 'There was a problem updating the employee.'
        render 'edit'
      end
	  else
	    if @employee.update(employee_params_restricted)
        flash[:success] = 'Employee profile updated!'
        redirect_to my_tickets_path
      else
        flash.now[:danger] = 'There was a problem updating the employee.'
        render 'edit'
      end
	  end
	end

	def assigned_tickets
		@tickets = Ticket.no_descriptions.where('technician_id = ?', @employee.id)
	end

	def hide
		@employee.update(hidden: true)
		flash[:success] = 'Employee hidden!'
		redirect_to new_employee_path
	end

	private

		def find_employee
			@employee = Employee.find_by!(user_name: params[:id])
		end

		def find_all_employees
		  @employees = Employee.not_hidden
		  @employees = apply_joins_and_order(@employees)
      @employees = apply_pagination(@employees)
		end

		def employee_params_admin
			params.require(:employee).permit(:first_name, :last_name, :user_name, :password, :password_confirmation, :office_id, :admin, :active, :hidden)
		end

		def employee_params_restricted
      params.require(:employee).permit(:first_name, :last_name, :user_name, :password, :password_confirmation, :office_id)
    end

end
