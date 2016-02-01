class TicketsController < ApplicationController
  before_action :restrict_to_technicians, only: [:index, :assigned_to_me, :assign_to_me]
  before_action :find_ticket, only: [:show, :edit, :update, :assign_to_me]
  before_action :check_for_unassigned, only: [:show, :edit, :update]
  before_action :restrict_to_originator_or_technicians, only: [:show, :edit, :update]

  # Employee-specific actions
  def my
    @tickets = Ticket.no_descriptions.where('originator_id = ?', current_employee.id)
  end

  # Mixed-rights actions
  def new
    @ticket = Ticket.new
  end

  def create
    @ticket = Ticket.new(ticket_params)
    @ticket.submitter = current_employee

    if @ticket.save
      flash[:success] = 'Ticket was successfully submitted!'
      default_tickets_redirect
    else
      @ticket.errors.any? ? flash[:danger] = 'Please fix the following errors.' : 'There was a problem submitting the ticket.'
      render 'new'
    end
  end

  def show
    @comment = Comment.new
  end

  def edit
  end

  def update
    if @ticket.update(ticket_params)
      flash[:success] = 'Ticket was successfully updated!'
      redirect_to ticket_path
    else
      @tcket.errors.any? ? flash[:danger] = 'Please fix the following errors.' : 'There was a problem updating the ticket.'
      render 'edit'
    end
  end

  # Technician-only actions
  def index
    if params[:employee_id]
      @employee = Employee.find_by!(username: params[:employee_id])
      @tickets = Ticket.no_descriptions.where('originator_id = ?', @employee.id)
    elsif params[:technician_id]
      @employee = Employee.find_by!(username: params[:technician_id])
      @tickets = Ticket.no_descriptions.where('technician_id = ?', @employee.id)
    else
      case params[:status]
      when 'all'
        @tickets = Ticket.no_descriptions
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
      end
    end
  end

  def assigned_to_me
    @tickets = Ticket.no_descriptions.where('technician_id = ?', current_employee.id)
  end

  def assign_to_me
    flash[:success] = "Ticket was assigned to you and set to 'Work in Progress.'"
    @ticket.update(status: :work_in_progress, technician: current_employee)
    redirect_to ticket_path
  end

  private

  def ticket_originator?
    @ticket.originator == current_employee
  end

  def ticket_submitter?
    @ticket.submitter == current_employee
  end

  def restrict_to_technicians
    unless technician? # SessionsHelper
      flash[:danger] = 'You are not authorized to do that!'
      redirect_to my_tickets_path
    end
  end

  def restrict_to_originator
    unless ticket_originator? # SessionsHelper
      flash[:danger] = 'You are not authorized to view that ticket!'
      redirect_to my_tickets_path
    end
  end

  def restrict_to_submitter
    unless ticket_submitter? # SessionsHelper
      flash[:danger] = 'You are not authorized to view that ticket!'
      redirect_to my_tickets_path
    end
  end

  def restrict_to_originator_or_technicians
    unless ticket_originator? || technician? # SessionsHelper
      flash[:danger] = 'You are not authorized to view that ticket!'
      redirect_to my_tickets_path
    end
  end

  def find_ticket
    @ticket = Ticket.find(params[:id])
  end

  # Checks for tickets assigned to a tech but status is still set to 'Unassigned'
  # This would ideally not let you save if this is the case but can't get that...
  # ...to work at the moment
  def check_for_unassigned
    if @ticket.technician != nil && @ticket.unassigned? && technician?
      flash[:danger] = "Ticket is assigned to a technician but status is set to 'Unassigned!'"
    end
  end

  def ticket_params
    params.require(:ticket).permit(:originator_id, :topic_id, :description, :technician_id, :priority)
  end

end
