class PostsController < ApplicationController
  before_action :require_creator, only: [:edit, :update]

  def show
    @post = Post.find(params[:id])
    @all_comments = @post.comments
    @comments = @post.comments.where(parent_comment_id: nil)
    render :show
  end

  def new
    @post = Post.new
    render :new
  end

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id
    if @post.save
      redirect_to @post
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    render :edit
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to @post
    else
      flash[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  private

  def post_params
    params.require(:posts).permit(:title, :url, :content, sub_ids: [])
  end

  def require_creator
    @post = Post.find(params[:id])
    unless @post.author == current_user
      flash[:errors] = "You do not have permissions for this sub"
      redirect_to @post
    end
  end
end
