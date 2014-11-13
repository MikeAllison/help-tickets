class CommentsController < ApplicationController
    
  before_action :find_comment, only: [:edit, :update, :destroy]
  
  def index
    @comments = Comment.all
  end

  def new
    @comment = Comment.new
  end

  def edit
  end

  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      flash[:success] = "Comment created!"
      redirect_to comments_path
    else
      render 'new'
    end
  end

  def update
    if @comment.update_attributes(comment_params)
      flash[:success] = "Comment updated!"
      redirect_to comments_path
    else
      render 'edit'
    end
  end

  def destroy
    @comment.destroy
  end

  private

    def find_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:ticket_id, :employee_id, :body)
    end
    
end
