module TicketsHelper
  
  # Sets color of flag icon in tickets/list partial
  def status_icon(state)
    icon = 'glyphicon glyphicon-'
    
    if state == 'Unassigned'
      icon = icon + 'thumbs-down alert-danger'
    elsif state == 'Work in Progress'
      icon = icon + 'wrench alert-warning'
    elsif state == 'On Hold'
      icon = icon + 'pause alert-warning'
    elsif state == 'Closed'
      icon = icon + 'thumbs-up alert-success'
    end
    
    content_tag :span, '', class: icon
  end
   
end