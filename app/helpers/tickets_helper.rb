module TicketsHelper

  # Sets color of flag icon in tickets/list partial
  def ticket_status_icon(ticket)
    icon = 'glyphicon glyphicon-floppy-disk'

    case ticket.status.to_sym
    when :unassigned
      icon = 'glyphicon glyphicon-floppy-remove'
      style = 'alert-danger'
    when :work_in_progress
      style = 'alert-warning'
    when :on_hold
      style = 'alert-warning'
    when :closed
      icon = 'glyphicon glyphicon-floppy-saved'
      style = 'alert-success'
    end

    content_tag :span, '', class: icon + ' ' + style, :'aria-hidden' => true
  end

end
