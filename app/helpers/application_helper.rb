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

  def panel_header
    c_name = controller_name.capitalize

    # params[:status] set in routes
    if params[:status].nil?
      a_name = action_name.capitalize
    else
      a_name = params[:status].split('_')
      a_name.map { |item| item.capitalize! }
      a_name = a_name.join(' ')
    end

    case a_name
    when 'Index'
      a_name = 'All'
    when 'New'
      a_name = 'Add'
      c_name.chop!
    when 'Create'
      a_name = 'Add'
      c_name.chop!
    when 'Edit'
      c_name.chop!
    end

    if a_name == 'Add' && c_name == 'Ticket'
      a_name = 'Create'
    elsif c_name == 'Citie'
      c_name = 'City'
    end

    if params[:employee_id] || params[:technician_id]
      emp_name = @employee.first_last

      if params[:employee_id]
        if emp_name.end_with?('s')
          a_name = emp_name + "'"
        else
          a_name = emp_name + "'s"
        end
      end

      if params[:technician_id]
        c_name = ''
        a_name = 'Tickets Assigned To ' + emp_name
      end
    end

    if action_name == 'assigned_to_me'
      c_name + ' ' + a_name
    else
      a_name + ' ' + c_name
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
