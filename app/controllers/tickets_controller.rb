class TicketsController < ApplicationController
	before_action :find_ticket, only: [:show, :edit, :update, :destroy]
  
	def index
	  @tickets = Ticket.all
	end

	def show
	end

	def open
		@tickets = Ticket.open
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
	    flash[:success] = "Ticket was successfully submitted!"
	    if current_employee.admin?
	    	redirect_to tickets_open_path
	    else
				redirect_to tickets_my_tickets_path
	  	end
	  else
	    render :new
	  end
	end
	
	private
		
		def find_ticket
			@ticket = Ticket.find(params[:id])
		end

		def ticket_params
	  	params.require(:ticket).permit(:employee_id, :topic_id, :description, :status_id)
	 	end
end