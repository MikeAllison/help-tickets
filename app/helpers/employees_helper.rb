module EmployeesHelper
  
  # Sets color of employee icon in employee/list partial
  def employee_status_icon(status)
    icon = 'glyphicon glyphicon-'
    
    if status == true
      icon += 'user alert-success'
    else
      icon += 'user alert-danger'
    end 
    
    content_tag :span, '', class: icon
  end
  
end