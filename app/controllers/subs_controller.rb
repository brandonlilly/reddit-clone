class SubsController < ApplicationController
  before_action :require_login, only: [:new, :create, :edit, :update]
  before_action :require_creator, only: [:edit, :update]

  def show
    @sub = Sub.find(params[:id])
    render :show
  end

  def new
    @sub = Sub.new
    render :new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.creator_id = current_user.id
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def edit
    @sub = Sub.find(params[:id])
    render :edit
  end

  def update
    @sub = Sub.find(params[:id])

    if @sub.update(sub_params)
      redirect_to @sub
    else
      flash[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  def index
    @subs = Sub.all
    render :index
  end

  private

  def sub_params
    params.require(:subs).permit(:title, :description)
  end

  def require_creator
    @sub = Sub.find(params[:id])
    unless @sub.creator == current_user
      flash[:errors] = "You do not have permissions for this sub"
      redirect_to @sub
    end
  end
end
