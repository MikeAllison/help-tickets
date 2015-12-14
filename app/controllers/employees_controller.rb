class EmployeesController < ApplicationController

  before_action :restrict_to_technicians, except: [:edit, :update]
  before_action :find_employee, only: [:edit, :update, :hide, :assigned_tickets]
  before_action :restrict_to_technicians_or_current_employee, only: [:edit, :update]
  before_action :find_all_employees, only: [:new, :create]

  def index
    case params[:status]
    when 'active'
      @employees = Employee.active.not_hidden
    when 'inactive'
      @employees = Employee.inactive.not_hidden
    when 'technicians'
      @employees = Employee.technician.not_hidden
    else
      @employees = Employee.not_hidden
    end
  end

  def new
    @employee = Employee.new
  end

  def create
    @employee = Employee.new(employee_params_technician)

    if @employee.save
      flash[:success] = 'Employee added!'
      redirect_to new_employee_path
    else
      @employee.errors.any? ? flash.now[:danger] = 'Please fix the following errors.' : 'There was a problem adding the employee.'
      render 'new'
    end
  end

  def edit
  end

  def update
    if technician?
      if @employee.update(employee_params_technician)
        flash[:success] = 'Employee profile updated!'
        redirect_to new_employee_path
      else
        @employee.errors.any? ? flash.now[:danger] = 'Please fix the following errors.' : 'There was a problem updating the employee.'
        render 'edit'
      end
    else
      if @employee.update(employee_params_restricted)
        flash[:success] = 'Employee profile updated!'
        redirect_to my_tickets_path
      else
        @employee.errors.any? ? flash.now[:danger] = 'Please fix the following errors.' : 'There was a problem updating your profile.'
        render 'edit'
      end
    end
  end

  def assigned_tickets
    @tickets = Ticket.no_descriptions.where('technician_id = ?', @employee.id)
    render 'tickets/index'
  end

  def hide
    @employee.hide
    flash[:success] = 'Employee hidden!'
    redirect_to new_employee_path
  end

  private

  def restrict_to_technicians_or_current_employee
    unless technician? || @employee == current_employee
      flash[:danger] = "You are not authorized to edit that employee's profile!"
      redirect_to edit_employee_path(current_employee)
    end
  end

  def find_employee
    @employee = Employee.find_by!(username: params[:id])
  end

  def find_all_employees
    @employees = Employee.not_hidden
  end

  def employee_params_technician
    params.require(:employee).permit(:fname, :lname, :username, :password, :password_confirmation, :office_id, :technician, :active, :hidden)
  end

  def employee_params_restricted
    params.require(:employee).permit(:fname, :lname, :username, :password, :password_confirmation, :office_id)
  end

end
