module EmployeesHelper

  # Sets color of employee icon in employee/list partial
  def employee_status_icon(status)
    icon = 'glyphicon glyphicon-'

    if status == true
      icon += 'user alert-success'
      title = 'Active'
    else
      icon += 'user alert-danger'
      title = 'Inactive'
    end

    content_tag :span, '', class: "status-icon #{icon}", title: title, data: { toggle: 'tooltip', placement: 'left' }, :'aria-hidden' => true
  end

  def assigned_tickets_link(employee)
    if employee.technician?
      link_to "#{employee.assigned_tickets.size}", assigned_tickets_employee_path(employee), title: 'Technican\'s Assigned Tickets', data: { toggle: 'tooltip', placement: 'top' }
    else
      raw("&mdash;")
    end
  end

end
