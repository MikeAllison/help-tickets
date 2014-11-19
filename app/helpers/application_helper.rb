module ApplicationHelper
  
  def panel_header
    # Could probably be moved into an array to remove duplicate code
    action_name = params[:action].split('_')
    controller_name = params[:controller].split('_')
    
    action_name.map { |item| item.capitalize! }
    controller_name.map { |item| item.capitalize! }
    
    action_name = action_name.join(' ')
    controller_name = controller_name.join(' ')
    
    case action_name
    when 'Index'
      action_name = 'All'
    when 'My Tickets'
      action_name = 'My'
    when 'New'
      action_name = 'Add'
      controller_name.chop!
      if controller_name == 'Ticket'
        action_name = 'Create'
      end
    end
        
    action_name + ' ' + controller_name
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