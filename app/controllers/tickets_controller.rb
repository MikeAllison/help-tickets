class TicketsController < ApplicationController
	
	before_action :restrict_access, only: [:index]
	before_action :find_ticket, only: [:show, :edit, :update, :close_ticket, :reopen_ticket, :destroy]
	before_action :check_unassigned, only: [:update]
	
	def index
	  filter = params[:filter]
	  status = params[:status]
	  
	  if filter == 'true'
	   case status
      when 'open'
        @tickets = Ticket.open.joins(join_table).order(sort_column + ' ' + sort_direction)  
      when 'unassigned'
        @tickets = Ticket.unassigned.joins(join_table).order(sort_column + ' ' + sort_direction)
      when 'work_in_progress'
        @tickets = Ticket.work_in_progress.joins(join_table).order(sort_column + ' ' + sort_direction)
      when 'on_hold'
        @tickets = Ticket.on_hold.joins(join_table).order(sort_column + ' ' + sort_direction)
      when 'closed'
        @tickets = Ticket.closed.joins(join_table).order(sort_column + ' ' + sort_direction)
      else
        @tickets = Ticket.joins(join_table).order(sort_column + ' ' + sort_direction)
      end
	  else
	   case status
      when 'open'
        @tickets = Ticket.open.joins(join_table).order(sort_column + ' ' + sort_direction).paginate(:page => params[:page])   
      when 'unassigned'
        @tickets = Ticket.unassigned.joins(join_table).order(sort_column + ' ' + sort_direction).paginate(:page => params[:page])
      when 'work_in_progress'
        @tickets = Ticket.work_in_progress.joins(join_table).order(sort_column + ' ' + sort_direction).paginate(:page => params[:page])
      when 'on_hold'
        @tickets = Ticket.on_hold.joins(join_table).order(sort_column + ' ' + sort_direction).paginate(:page => params[:page])
      when 'closed'
        @tickets = Ticket.closed.joins(join_table).order(sort_column + ' ' + sort_direction).paginate(:page => params[:page])
      else
        @tickets = Ticket.joins(join_table).order(sort_column + ' ' + sort_direction).paginate(:page => params[:page])
      end
	  end
	  
	end
	
	def my
	  @tickets = Ticket.where('creator_id = ?', current_employee.id).order(created_at: :desc).paginate(:page => params[:page])
	end

	def show
	  if admin? || @ticket.employee_id == current_employee.id
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
	
	def close_ticket
	  # Sets ticket.status.state to 'Closed'
	  flash[:success] = "Ticket closed!"
	  @ticket.update_attribute(:status_id, 4)
	  default_tickets_redirect
	end
	
	def reopen_ticket
	  flash[:success] = "Ticket re-opened!"
	  @ticket.update_attribute(:status_id, 1)
	  default_tickets_redirect
	end
	
	private
		
		def find_ticket
			@ticket = Ticket.find(params[:id])
		end
		
		def check_unassigned
		  if @ticket.technician_id != '' && @ticket.status_id == 1
        flash.now[:danger] = "Please change state to something other than 'Unassigned!'"
        render 'edit'
      else
        return
      end
		end
		
		def ticket_params
	  	params.require(:ticket).permit(:creator_id, :topic_id, :description, :status_id, :technician_id)
	 	end
end