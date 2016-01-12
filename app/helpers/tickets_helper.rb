module TicketsHelper

  # Sets icon for urgent tickets
  def ticket_priority_icon(ticket)
    if ticket.urgent?
      content_tag :span, '', class: 'priority-icon glyphicon glyphicon-warning-sign', :'aria-hidden' => true
    end
  end

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

  def time_to_hours_minutes(time_in_seconds)
    calculated_minutes = (time_in_seconds % 3600) / 60
    calculated_minutes += 1 if calculated_minutes > 0
    calculated_hours = (time_in_seconds % 86400) / 3600
    calculated_days = time_in_seconds / 86400

    formatted_time = "#{calculated_minutes} minutes"

    if calculated_days > 0
      formatted_time.insert(0, "#{calculated_days} days #{calculated_hours} hours ")
    elsif calculated_hours > 0
      formatted_time.insert(0, "#{calculated_hours} hours ")
    else
      formatted_time
    end
  end

end
