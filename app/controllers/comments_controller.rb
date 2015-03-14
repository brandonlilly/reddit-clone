class CommentsController < ApplicationController
  def new
    @comment = Comment.new(post_id: params[:id])
    render :new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.author_id = current_user.id
    if @comment.save
      redirect_to @comment.post
    else
      flash.now[:errors] = @comment.errors.full_messages
      render :new
    end
  end

  def show
    @comment = Comment.find(params[:id])
    @child_comment = Comment.new(parent_comment_id: @comment.id, post_id: @comment.post_id)
    render :show
  end

  private

  def comment_params
    params.require(:comments).permit(:content, :post_id, :parent_comment_id)
  end
end
