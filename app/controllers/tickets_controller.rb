class TicketsController < ApplicationController
	
	before_action :find_ticket, only: [:show, :edit, :update, :destroy]
	
	def index
	  @tickets = Ticket.joins(join_table).order(sort_by + ' ' + sort_direction).paginate(:page => params[:page])
	end

	def show
	end

	def open
		@tickets = Ticket.open.joins(join_table).order(sort_by + ' ' + sort_direction).paginate(:page => params[:page])
	end
	
	def my_tickets
	  @tickets = Ticket.where('employee_id = ?', @current_employee.id).order(created_at: :desc).paginate(:page => params[:page])
	  #@tickets = Ticket.my_tickets
	end
	
	def unassigned
	  @tickets = Ticket.unassigned.joins(join_table).order(sort_by + ' ' + sort_direction).paginate(:page => params[:page])
	end
	
	def work_in_progress
	  @tickets = Ticket.work_in_progress.joins(join_table).order(sort_by + ' ' + sort_direction).paginate(:page => params[:page])
	end
	
	def on_hold
	  @tickets = Ticket.on_hold.joins(join_table).order(sort_by + ' ' + sort_direction).paginate(:page => params[:page])
	end
	
	def closed
	  @tickets = Ticket.closed.joins(join_table).order(sort_by + ' ' + sort_direction).paginate(:page => params[:page])
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
    
    # Converts join table to symbol for use in .joins method	
	  def join_table
	    params[:joins].to_sym unless params[:joins].nil?
	  end
	  
	  # Set default column to sort
	  def sort_by
	    params[:sort_by] || "created_at"
	  end
	  
	  # Set default sort direction
	  def sort_direction
	    params[:direction] || "DESC"
	  end
		
		def find_ticket
			@ticket = Ticket.find(params[:id])
		end
		
		def ticket_params
	  	params.require(:ticket).permit(:employee_id, :topic_id, :description, :status_id)
	 	end
end