class TicketsController < ApplicationController
	
	before_action :find_ticket, only: [:show, :edit, :update, :destroy]
	
	helper_method :sort_column, :sort_direction
  
	def index
	  @tickets = Ticket.order(sort_column + " " + sort_direction).paginate(:page => params[:page])
	end

	def show
	end

	def open
		@tickets = Ticket.open.order(sort_column + " " + sort_direction).paginate(:page => params[:page])
	end
	
	def my_tickets
	  @tickets = Ticket.where('employee_id = ?', @current_employee.id).order(sort_column + " " + sort_direction).paginate(:page => params[:page])
	  #@tickets = Ticket.my_tickets
	end
	
	def unassigned
	  @tickets = Ticket.unassigned.order(sort_column + " " + sort_direction).paginate(:page => params[:page])
	end
	
	def work_in_progress
	  @tickets = Ticket.work_in_progress.order(sort_column + " " + sort_direction).paginate(:page => params[:page])
	end
	
	def on_hold
	  @tickets = Ticket.on_hold.order(sort_column + " " + sort_direction).paginate(:page => params[:page])
	end
	
	def closed
	  @tickets = Ticket.closed.order(created_at: :desc).paginate(:page => params[:page])
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
		
		def sort_column
		  params[:sort] || "created_at"
		end
		
		def sort_direction
		  params[:direction] || "asc"
		end

		def ticket_params
	  	params.require(:ticket).permit(:employee_id, :topic_id, :description, :status_id)
	 	end
end