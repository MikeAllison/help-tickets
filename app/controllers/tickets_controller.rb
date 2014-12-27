class TicketsController < ApplicationController
	
	before_action :restrict_access, only: [:index]
	before_action :find_ticket, only: [:show, :edit, :update, :assign_to_me, :close_ticket, :reopen_ticket, :destroy]
	before_action :check_for_unassigned, only: [:show, :edit, :update]
	
	def index
	  if params[:employee_id]
	    @employee = Employee.find(params[:employee_id])
      @tickets = Ticket.no_descriptions.where('creator_id = ?', @employee.id)
    elsif params[:technician_id]
      @employee = Employee.find(params[:technician_id])
      @tickets = Ticket.no_descriptions.where('technician_id = ?', @employee.id)
	  else	  	  
  	  case params[:status]
  	  when 'open'
  	    @tickets = Ticket.no_descriptions.open
  	  when 'unassigned'
  	    @tickets = Ticket.no_descriptions.unassigned
  	  when 'work_in_progress'
  	    @tickets = Ticket.no_descriptions.work_in_progress
  	  when 'on_hold'
  	    @tickets = Ticket.no_descriptions.on_hold
  	  when 'closed'
  	    @tickets = Ticket.no_descriptions.closed
  	  else
  	    @tickets = Ticket.no_descriptions
  	  end
  	end
	  
	  @tickets = apply_joins_and_order(@tickets)
	  @tickets = apply_pagination(@tickets)
	end
	
	def assigned_to_me
	  @tickets = Ticket.no_descriptions.where('technician_id = ?', current_employee.id)
    @tickets = apply_joins_and_order(@tickets)
    @tickets = apply_pagination(@tickets)
  end
	
	def my
	  @tickets = Ticket.no_descriptions.where('creator_id = ?', current_employee.id)
	  @tickets = apply_joins_and_order(@tickets)
    @tickets = apply_pagination(@tickets)
	end

	def show
	  if admin? || @ticket.creator_id == current_employee.id
      render 'show'
	  else
	    flash[:danger] = "You are not authorized to view that ticket!"
	    redirect_to tickets_my_path
	  end
	end
	
	def new
	  @ticket = Ticket.new
	end
	
	def create
	  # @ticket.status_id set to 1 (Unassigned) by default
	  @ticket = Ticket.new(ticket_params)
	  
	  if @ticket.save
	    flash[:success] = "Ticket was successfully submitted!"
	    default_tickets_redirect
	  else
	    flash.now[:danger] = "There was a problem submitting the ticket."
	    render 'new'
	  end
	end
	
	def update
    if @ticket.update_attributes(ticket_params)
	    flash[:success] = "Ticket was successfully updated!"
	    redirect_to ticket_path
	  else
	    flash.now[:danger] = "There was a problem updating the ticket."
	    render 'edit'
	  end
	end
	
	def assign_to_me
	  flash[:success] = "Ticket was assigned to you and set to 'Work in Progress.'"
	  @ticket.update_attributes(technician_id: current_employee.id, status_id: 2)
	  redirect_to ticket_path
	end
	
	def close_ticket
	  # Sets ticket.status.state to 'Closed'
	  flash[:success] = "Ticket closed!"
	  if @ticket.technician_id.nil?
	    @ticket.update_attribute(:technician_id, current_employee.id)
	  end
	  @ticket.update_attribute(:status_id, 4)
	  default_tickets_redirect
	end
	 
	def reopen_ticket
	  flash[:success] = "Ticket re-opened!"
	  @ticket.update_attributes(status_id: 1, technician_id: nil)
	  default_tickets_redirect
	end
	
	private
		
		def find_ticket
			@ticket = Ticket.find(params[:id])
		end
		
		# Checks for tickets assigned to a tech but status is still set to 'Unassigned'
		# This would ideally not let you save if this is the case but can't get that...
		# ...to work at the moment
		def check_for_unassigned
		  if @ticket.technician_id != nil && @ticket.status_id == 1 && current_employee.admin?
        flash.now[:danger] = "Ticket is assigned to a technician but status is set to 'Unassigned!'"
      end
		end
		
		def ticket_params
	  	params.require(:ticket).permit(:creator_id, :topic_id, :description, :status_id, :technician_id)
	 	end
end