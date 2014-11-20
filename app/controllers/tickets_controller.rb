class TicketsController < ApplicationController
	
	before_action :find_ticket, only: [:show, :edit, :update, :close_ticket, :destroy]
	
	def index
	  status = params[:status]
	  
	  case status
	  when 'open'
	    @tickets = Ticket.open.joins(join_table).order(sort_by + ' ' + sort_direction).paginate(:page => params[:page])
    when 'my_tickets'
      @tickets = Ticket.where('employee_id = ?', @current_employee.id).order(created_at: :desc).paginate(:page => params[:page])
    when 'unassigned'
      @tickets = Ticket.unassigned.joins(join_table).order(sort_by + ' ' + sort_direction).paginate(:page => params[:page])
    when 'work_in_progress'
      @tickets = Ticket.work_in_progress.joins(join_table).order(sort_by + ' ' + sort_direction).paginate(:page => params[:page])
    when 'on_hold'
      @tickets = Ticket.on_hold.joins(join_table).order(sort_by + ' ' + sort_direction).paginate(:page => params[:page])
    when 'closed'
      @tickets = Ticket.closed.joins(join_table).order(sort_by + ' ' + sort_direction).paginate(:page => params[:page])
    else
      @tickets = Ticket.joins(join_table).order(sort_by + ' ' + sort_direction).paginate(:page => params[:page])
	  end
	end

	def show
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
	
	def update
	  if @ticket.update_attributes(ticket_params)
	    flash[:success] = "Ticket was successfully updated!"
	    redirect_to ticket_path
	  else
	    flash.now[:danger] = "There was a problem updating the ticket."
	    render 'edit'
	  end
	end
	
	def close_ticket
	  # Sets ticket.status.state to 'Closed'
	  flash[:success] = "Ticket closed!"
	  @ticket.update_attribute(:status_id, 4)
	  redirect_to tickets_open_path
	end
	
	private
		
		def find_ticket
			@ticket = Ticket.find(params[:id])
		end
		
		def ticket_params
	  	params.require(:ticket).permit(:employee_id, :topic_id, :description, :status_id)
	 	end
end