module TicketsHelper
  
  def action_name
    status = params[:action].split('_')
    status.map { |item| item.capitalize! }
    status = status.join(' ')
    
    if status == 'Index'
      status = 'All'
    else
      status
    end
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