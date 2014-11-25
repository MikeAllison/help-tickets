class SessionsController < ApplicationController
  
  skip_before_action :require_login, only: [:new, :create]
  
  def new
  end
  
  def create
    employee = Employee.find_by(user_name: params[:session][:user_name].downcase)
    
    if employee && employee.authenticate(params[:session][:password])
      log_in employee
      flash[:success] = "You are logged in!"
      default_tickets_redirect
    else
      flash.now[:danger] = "Invalid credentials!"
      render 'new'
    end
  end
  
  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

end