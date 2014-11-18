module ApplicationHelper
  
  def panel_header
    action_name = params[:action].split('_')
    action_name.map { |item| item.capitalize! }
    action_name = action_name.join(' ')
    
    controller_name = params[:controller].split('_')
    controller_name.map { |item| item.capitalize! }
    controller_name = controller_name.join(' ')
    
    if action_name == 'Index'
      action_name = 'All'
    end
    # Need to add count to end of header
    action_name + ' ' + controller_name
  end
  
end