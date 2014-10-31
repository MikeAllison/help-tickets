class SessionsController < ApplicationController
  def new
  end
  
  def create
    employee = Employee.find_by(user_name: params[:session][:user_name].downcase)
    
    if employee && employee.authenticate(params[:session][:password])
      log_in employee
      flash[:success] = "You are logged in!"
      redirect_to employee_tickets_path
    else
      flash.now[:danger] = 'Invalid credentials!'
      render 'new'
    end
  end
  
  def destroy
    
  end
end
