module ApplicationHelper
  
  def controller_name_singularize
    c_name = controller_name.to_s.chop
    
    case c_name
    when 'citie'
      c_name = 'city'
    else
      c_name
    end
  end
  
  def submit_button
    c_name = controller_name_singularize.capitalize
    
    if action_name == 'new' || action_name == 'create'
      submit_tag 'Add ' + c_name, class: 'btn btn-primary'
    else
      submit_tag 'Update ' + c_name, class: 'btn btn-primary'
    end
  end
  
  def cancel_button
    if action_name == 'edit' || action_name == 'update'
      link_to "Cancel", :back, class: 'btn btn-default'
    elsif controller_name == 'tickets' && action_name == 'new' || action_name == 'create'
      link_to "Cancel", :back, class: 'btn btn-default'
    end
  end
  
  def panel_header
    c_name = controller_name.capitalize
    
    # params[:status] set in routes
    if params[:status].nil?
      a_name = action_name.capitalize
    else
      a_name = params[:status].split('_')
      a_name.map { |item| item.capitalize! }
      a_name = a_name.join(' ')
    end
    
    case a_name
    when 'Index'
      a_name = 'All'
    when 'New'
      a_name = 'Add'
      c_name.chop!
    when 'Create'
      a_name = 'Add'
      c_name.chop!
    when 'Edit'
      c_name.chop!
    end
    
    if a_name == 'Add' && c_name == 'Ticket'
      a_name = 'Create'
    elsif c_name == 'Citie'
      c_name = 'City'
    end
      
    a_name + ' ' + c_name
  end
  
  # Creates a link for table headers with params to sort
  # :join_table is converted to symbol in ApplicationController
  # Default sorting is set in ApplicationController 
  def sort_column(title, column, joins = nil)
    if column == params[:sort_column] && params[:sort_direction] == 'ASC'
      direction = 'DESC'
    else
      direction = 'ASC'
    end
    
    link_to title, :sort_column => column, :sort_direction => direction, :join_table => joins
  end
  
  def filter_link
    link_to 'Filter', { :filter => true }, { class: 'btn btn-default ' }
  end
  
end