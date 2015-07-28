module ApplicationHelper

  def controller_name_singularize
    c_name = controller_name.to_s.chop

    case c_name
    when 'citie'
      c_name = 'city'
    else
      c_name
    end
  end

  def submit_button_add_update(obj)
    submit_tag (obj.new_record? ? "Add" : "Update") + " #{obj.class}", class: 'btn btn-primary'
  end

  def submit_button_create_update(obj)
    submit_tag (obj.new_record? ? "Create" : "Update") + " #{obj.class}", class: 'btn btn-primary'
  end

  # Formats the header for each page based on model and action
   def page_header
     obj = controller_name

     # Sets the first word:
     # 'Index Objects' -> 'All Objects'
     # 'New Objects' -> 'Add Objects'
     # 'Edit Objects' -> 'Edit Object'
     if params[:status] # If params[:status] is passed in routes.rb
       first_word = params[:status]
     elsif action_name == 'index'
       first_word = 'All'
     elsif action_name == 'new'
       first_word = 'Add'
     elsif action_name == 'edit'
       first_word = 'Edit'
       obj = obj.singularize
     end

     # Fixes for edge case issues or returns the standard header
     if action_name == 'new' && controller_name == 'tickets'
       'Create a Ticket'
     elsif action_name == 'assigned_to_me'
       "#{obj.titleize} #{first_word.titleize}"
     elsif params[:employee_id]
       raw "Tickets for #{@employee.first_name}"
     elsif params[:technician_id]
       raw "Tickets Assigned to #{@employee.first_name}"
     elsif controller_name == 'tickets' && action_name == 'edit'
       "Edit Ticket #{@ticket.id}"
     else
       "#{first_word.titleize} #{obj.titleize}"
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
