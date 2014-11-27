class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  
  before_action :require_login
  
  private
    
    def restrict_access
      unless admin?
        flash[:danger] = "You are not authorized to view that page!"
        redirect_to tickets_my_path
      end
    end
    
    def default_tickets_redirect
      if admin?
        redirect_to tickets_open_path
      else
        redirect_to tickets_my_path
      end
    end
  
    # Converts join table to symbol for use with sort_column in ApplicationHelper 
    def join_table
      join_table = params[:join_table] || nil
      join_table.to_sym if !join_table.nil?
    end
    
    # Set default sorting column with sort_column in ApplicationHelper
    def sort_column
      case controller_name
      when 'tickets'
        sort_column = 'created_at'
      when 'employees'
        sort_column = 'last_name'
      when 'offices'
        sort_column = 'name'
      when 'topics'
        sort_column = 'system'
      when 'cities'
        sort_column = 'name'
      end
      
      params[:sort_column] || sort_column
    end
    
    # Set default sorting direction with sort_column in ApplicationHelper
    def sort_direction
      case controller_name
      when 'tickets'
        sort_direction = 'DESC'
      else
        sort_direction = 'ASC'
      end
      
      params[:sort_direction] || sort_direction
    end
    
end