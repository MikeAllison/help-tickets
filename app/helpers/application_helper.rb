module ApplicationHelper

  ### LAYOUT-RELATED HELPERS ###

  # Sets glyphicon in flash messages
  def glyphicon(type)
   if type == 'danger'
     glyph_type = 'exclamation'
   elsif type == 'success'
     glyph_type = 'ok'
   else
     glyph_type = 'info'
   end

   content_tag :span, nil, class: "glyphicon glyphicon-#{glyph_type}-sign", :'aria-hidden' => true
  end

  # Sets an icon for the status field for various items based on 'active' field in DB
  def generic_status_icon(obj)
    if obj.active?
      icon = 'glyphicon glyphicon-ok alert-success'
      title = 'Active'
    else
      icon = 'glyphicon glyphicon-remove alert-danger'
      title = 'Inactive'
    end

    content_tag :span, '', class: icon, title: title, data: { toggle: 'tooltip', placement: 'left' }, :'aria-hidden' => true
  end

  def submit_button_add_update(obj)
    submit_tag (obj.new_record? ? "Add" : "Update") + " #{obj.class}", class: 'btn btn-primary'
  end

  def submit_button_create_update(obj)
    submit_tag (obj.new_record? ? "Create" : "Update") + " #{obj.class}", class: 'btn btn-primary'
  end

  # Formats the header for each page based on model and action
  def page_header
    actions = { index: 'all', new: 'add', edit: 'edit' }
    action = params[:status] || actions[action_name.to_sym]

    model = controller_name
    model = model.singularize if action_name == 'edit'

    # Fixes for edge cases or returns the standard header
    if action_name == 'new' && controller_name == 'tickets'
      'Create a Ticket'
    elsif params[:status] == 'assigned_to_me' || params[:status] == 'on_hold'
      "#{model} #{action}".titleize
    elsif params[:status] == 'work_in_progress'
      'Tickets In Progress'
    elsif params[:employee_id]
      "Tickets for #{@employee.fname} #{@employee.lname}"
    elsif action_name == 'assigned_tickets'
      "Tickets Assigned to #{@employee.fname} #{@employee.lname}"
    elsif controller_name == 'tickets' && action_name == 'edit'
      "Edit Ticket #{@ticket.id}"
    elsif controller_name == 'employees' && params[:status] == 'technicians'
      'Technician Employees'
    else
      "#{action} #{model}".titleize
    end
  end

end
