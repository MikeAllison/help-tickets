module ApplicationHelper
  
  def panel_header
    # Could probably be moved into an array to remove duplicate code
    action = action_name.split('_')
    controller = controller_name.split('_')
   
    action.map { |item| item.capitalize! }
    controller.map { |item| item.capitalize! }
    
    action = action.join(' ')
    controller = controller.join(' ')
    
    case action
    when 'Index'
      action = 'All'
    when 'My Tickets'
      action = 'My'
    when 'New'
      action = 'Add'
      controller.chop!
      if controller == 'Ticket'
        action = 'Create'
      end
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