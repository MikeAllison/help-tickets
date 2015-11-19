class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include SessionsHelper

  before_action :require_login

  private

  def restrict_to_technicians
    unless technician?
      flash[:danger] = 'That action requires technician rights!'
      redirect_to my_tickets_path
    end
  end

  def default_tickets_redirect
    if technician?
      redirect_to assigned_to_me_tickets_path
    else
      redirect_to my_tickets_path
    end
  end

end
