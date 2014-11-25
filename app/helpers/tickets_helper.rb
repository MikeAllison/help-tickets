module TicketsHelper
  
  # Sets color of flag icon in tickets/list partial
  def status_icon(state)
    if state == 'Unassigned'
      style = 'danger'
    elsif state == 'Work in Progress'
      style = 'warning'
    elsif state == 'On Hold'
      style = 'warning'
    elsif state == 'Closed'
      style = 'success'
    end
    
    content_tag :span, '', class: 'glyphicon glyphicon-flag alert-' + style
  end
   
end