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
    
    content_tag(:span, '', class: icon, title: title, data: { toggle: 'tooltip', placement: 'left' } )
  end
  
end