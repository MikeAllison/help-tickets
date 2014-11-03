class TicketsController < ApplicationController
	def index
	  # Broken
		@tickets = Ticket.find_by(id: params[:employee_id])
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
