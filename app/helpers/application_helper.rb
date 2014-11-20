module ApplicationHelper
  
  def panel_header
    status = params[:status]
    action = action_name
    controller = controller_name.capitalize
    
    if status.nil?
      # Use the action name
      action
    else
      # Use the status name
      # Split into array, capitalize each word, convert to string
      action = status
      action = action.split('_')
      action = action.map { |item| item.capitalize! }
      action = action.join(' ')
    end
    
    # Change 'index' to 'All' and 'new' to 'Add'
    # Un-pluralize controller name on new views
    if action == 'index'
      action = 'All'
    elsif action == 'new'
      action = 'Add'
      controller.chop!
    else
      action
    end
    
    # Change 'Add Ticket' to 'Create Ticket'
    if action == 'Add' && controller == 'Ticket'
      action = 'Create'
    end
      
    action + ' ' + controller
  end
  
  # Creates a link for table headers with params to sort 
  def sort_column(title, column, join_table = nil)
    if column == params[:sort_by] && params[:direction] == "ASC"
      direction = "DESC"
    else
      direction = "ASC"
    end
    link_to title, :sort_by => column, :joins => join_table, :direction => direction
  end
  
end