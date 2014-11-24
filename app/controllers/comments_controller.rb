class CommentsController < ApplicationController
   
  before_action :restrict_access, except: :create
  before_action :find_ticket
  
  def create
    @comment = @ticket.comments.new(comment_params)
    @comment.employee_id = current_employee.id

    if @comment.save 
      if @comment.closing_comment == true
        redirect_to close_ticket_path(@ticket)
      elsif @comment.reopening_comment == true
        redirect_to reopen_ticket_path(@ticket)
      else
        flash[:success] = "Comment created!"
        redirect_to @ticket
      end
    else
      flash[:danger] = "There was a problem adding the comment."
      if @comment.closing_comment == true
        redirect_to @ticket
      else
        redirect_to @ticket
      end
    end
  end

  private

    def find_ticket
      @ticket = Ticket.find(params[:ticket_id])
    end

    def comment_params
      params.require(:comment).permit(:ticket_id, :employee_id, :body, :closing_comment, :reopening_comment)
    end
    
end
