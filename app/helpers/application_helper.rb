module ApplicationHelper
  
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
    when 'Edit'
      c_name.chop!
    when 'My Tickets'
      a_name = 'My'
    end
    
    if a_name == 'Add' && c_name == 'Ticket'
      a_name = 'Create'
    elsif c_name == 'Citie'
      c_name = 'City'
    end
      
    a_name + ' ' + c_name
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