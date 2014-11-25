module TicketsHelper
  
  # Sets color of flag icon in tickets/list partial
  def ticket_status_icon(state)
    icon = 'glyphicon glyphicon-'
    
    case state 
    when 'Unassigned'
      icon += 'thumbs-down alert-danger'
    when 'Work in Progress'
      icon += 'wrench alert-warning'
    when 'On Hold'
      icon += 'pause alert-warning'
    when 'Closed'
      icon += 'thumbs-up alert-success'
    end
    
    content_tag :span, '', class: icon
  end
   
end