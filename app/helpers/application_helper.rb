module ApplicationHelper

  def submit_button_add_update(obj)
    submit_tag (obj.new_record? ? "Add" : "Update") + " #{obj.class}", class: 'btn btn-primary'
  end

  def submit_button_create_update(obj)
    submit_tag (obj.new_record? ? "Create" : "Update") + " #{obj.class}", class: 'btn btn-primary'
  end

  # Formats the header for each page based on model and action
  def page_header
    actions = { index: "all", new: "add", edit: "edit" }
    model = controller_name
    model = model.singularize if action_name == 'edit'

    action = params[:status] || actions[action_name.to_sym]

    # Fixes for edge cases or returns the standard header
    if action_name == 'new' && controller_name == 'tickets'
      'Create a Ticket'
    elsif params[:status] == 'assigned_to_me' || params[:status] == 'on_hold'
      "#{model} #{action}".titleize
    elsif params[:status] == 'work_in_progress'
      "Tickets In Progress"
    elsif params[:employee_id]
      "Tickets for #{@employee.first_name} #{@employee.last_name}"
    elsif params[:technician_id]
      "Tickets Assigned to #{@employee.first_name} #{@employee.last_name}"
    elsif controller_name == 'tickets' && action_name == 'edit'
      "Edit Ticket #{@ticket.id}"
    else
      "#{action} #{model}".titleize
    end
  end

  # Creates a link for table headers with params to sort
  # :join_table is converted to symbol in ApplicationController
  # Default sorting is set in ApplicationController
  def sort_column(title, column, joins = nil)
    if column == params[:sort_column] && params[:sort_direction] == 'ASC'
      direction = 'DESC'
    else
      direction = 'ASC'
    end

    link_to title, { :sort_column => column, :sort_direction => direction, :join_table => joins }, { title: 'Click to Sort', data: { toggle: 'tooltip', placement: 'top' } }
  end

  def filter_link
    link_to 'Filter', { :filter => true }, { class: 'btn btn-default', title: 'Load All Records & Enable Filter', data: { toggle: 'tooltip', placement: 'right' } }
  end

end
