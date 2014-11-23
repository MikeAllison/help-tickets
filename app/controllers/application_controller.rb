class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  
  before_action :require_login
  
  private
    
    def restrict_access
      unless @current_employee.admin?
        redirect_to tickets_my_tickets_path
      end
    end
  
    # Converts join table to symbol for use in .joins method  
    def join_table
      params[:joins].to_sym unless params[:joins].nil?
    end
    
    # Set default column to sort
    def sort_by
      params[:sort_by] || "created_at"
    end
    
    # Set default sort direction
    def sort_direction
      params[:direction] || "DESC"
    end
end