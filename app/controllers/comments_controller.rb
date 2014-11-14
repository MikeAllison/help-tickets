class CommentsController < ApplicationController
    
  before_action :find_ticket
  
  def create
    @comment = @ticket.comments.new(comment_params)

    if @comment.save
      flash[:success] = "Comment created!"
      redirect_to @ticket
    else
      flash.now[:danger] = "There was a problem adding the comment."
      render 'new'
    end
  end

  private

    def find_ticket
      @ticket = Ticket.find(params[:ticket_id])
    end

    def comment_params
      params.require(:comment).permit(:ticket_id, :employee_id, :body)
    end
    
end
