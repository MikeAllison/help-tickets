module SessionsHelper

  def log_in(employee)
    session[:employee_id] = employee.id
  end
  
  def current_employee
    @current_employee ||= Employee.find_by(id: session[:employee_id])
  end
  
  def logged_in?
    !current_employee.nil?
  end
  
  def require_login
    unless logged_in?
      flash[:danger] = "Please sign in."
      redirect_to login_url
    end
  end
  
  def log_out
    session.delete(:employee_id)
    @current_employee = nil
  end

end
