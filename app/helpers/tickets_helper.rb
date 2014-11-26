module TicketsHelper
  
  # Sets color of flag icon in tickets/list partial
  def ticket_status_icon(state)
    icon = 'glyphicon glyphicon-floppy-disk'
    
    case state 
    when 'Unassigned'
      icon = 'glyphicon glyphicon-floppy-remove'
      style = 'alert-danger'
    when 'Work in Progress'
      style = 'alert-warning'
    when 'On Hold'
      style = 'alert-warning'
    when 'Closed'
      icon = 'glyphicon glyphicon-floppy-saved'
      style = 'alert-success'
    end
    
    content_tag :span, '', class: icon + ' ' + style
  end
   
end