class CommentsController < ApplicationController

  before_action :restrict_to_technicians, except: :create
  before_action :find_ticket

  def create
    @comment = @ticket.comments.build(comment_params)
    @comment.employee_id = current_employee.id

    if @comment.save
      if @comment.closing?
        @ticket.close(current_employee)
        flash[:success] = 'Ticket closed!'
        default_tickets_redirect
      elsif @comment.reopening?
        @ticket.reopen(current_employee)
        flash[:success] = 'Ticket re-opened!'
        redirect_to @ticket
      else
        flash[:success] = 'Comment added!'
        redirect_to @ticket
      end
    else
      @comment.errors.any? ? flash[:danger] = 'Please fix the following errors.' : 'There was a problem adding the comment.'
      render 'tickets/show'
    end
  end

  private

  def find_ticket
    @ticket = Ticket.find(params[:ticket_id])
  end

  def comment_params
    params.require(:comment).permit(:ticket_id, :employee_id, :body, :status_type)
  end

end
