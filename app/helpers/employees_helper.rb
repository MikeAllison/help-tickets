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

  def tickets_created_link(employee)
    link_to "#{employee.originated_tickets.size}", employee_tickets_path(employee), title: "Tickets For: #{employee.first_last}" , data: { toggle: 'tooltip', placement: 'top' }
  end

  def tickets_assigned_link(employee)
    if employee.technician?
      link_to "#{employee.assigned_tickets.size}", assigned_tickets_employee_path(employee), title: "Tickets Assigned To: #{employee.first_last}", data: { toggle: 'tooltip', placement: 'top' }
    else
      raw("&mdash;")
    end
  end
end
