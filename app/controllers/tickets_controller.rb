class TicketsController < ApplicationController
	
	before_action :find_ticket, only: [:show, :edit, :update, :destroy]
  
	def index
	  @tickets = Ticket.all.order(:created_at).paginate(:page => params[:page])
	end

	def show
	end

	def open
		@tickets = Ticket.open.order(:created_at).paginate(:page => params[:page])
	end
	
	def my_tickets
	  @tickets = Ticket.where('employee_id = ?', @current_employee.id).order(:created_at).paginate(:page => params[:page])
	  #@tickets = Ticket.my_tickets
	end
	
	def unassigned
	  @tickets = Ticket.unassigned.order(:created_at).paginate(:page => params[:page])
	end
	
	def work_in_progress
	  @tickets = Ticket.work_in_progress.order(:created_at).paginate(:page => params[:page])
	end
	
	def on_hold
	  @tickets = Ticket.on_hold.order(:created_at).paginate(:page => params[:page])
	end
	
	def closed
	  @tickets = Ticket.closed.order(:created_at).paginate(:page => params[:page])
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
        redirect_to tickets_my_ticket_path
	  	end
	  else
	    flash.now[:danger] = "There was a problem submitting the ticket."
	    render 'new'
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