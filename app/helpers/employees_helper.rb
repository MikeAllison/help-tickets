module EmployeesHelper
  
  # Sets color of employee icon in employee/list partial
  def employee_status_icon(status)
    icon = 'glyphicon glyphicon-'
    
    if status == true
      icon += 'user alert-success'
      tooltip = 'Active'
    else
      icon += 'user alert-danger'
      tooltip = 'Inactive'
    end 
    
    content_tag :span, '', { class: icon, title: tooltip }
  end
  
end