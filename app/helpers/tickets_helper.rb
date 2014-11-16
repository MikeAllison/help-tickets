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
  
  def sortable(column, title)
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, :sort => column, :direction => direction
  end
    
end