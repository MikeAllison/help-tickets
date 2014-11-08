class TicketsController < ApplicationController
  
	def index
	  @tickets = Ticket.all
	end
	
	def my_tickets
	  @tickets = Ticket.where('employee_id = ?', @current_employee.id)
	  #@tickets = Ticket.my_tickets
	end
	
	def unassigned
	  @tickets = Ticket.unassigned
	end
	
	def work_in_progress
	  @tickets = Ticket.work_in_progress
	end
	
	def on_hold
	  @tickets = Ticket.on_hold
	end
	
	def closed
	  @tickets = Ticket.closed
	end
	
	def new
	  @ticket = Ticket.new
	end
	
	def create
	  @ticket = Ticket.new(ticket_params)
	  
	  if @ticket.save
	    flash[:success] = 'Ticket was successfully submitted!'
	    redirect_to employee_tickets_path
	  else
	    render :new
	  end
	end
	
	private
	
	 def ticket_params
	   params.require(:ticket).permit(:employee_id, :topic_id, :description)
	 end
end
