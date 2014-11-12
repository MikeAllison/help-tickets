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
  
end