class SubsController < ApplicationController

  before_action :require_current_user, except: [:index, :show]

  def new
    @sub = Sub.new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.moderator = current_user

    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def index
    @subs = Sub.all
  end

  def show
    @sub = Sub.find_by(id: params[:id])
  end

  def edit
    @sub = Sub.find_by(id: params[:id])

  end

  def update
    @sub = current_user.subs.find_by(id: params[:id])
    if @sub.update_attributes(sub_params)
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  def destroy
    @sub = current_user.subs.find_by(id: params[:id])
    @sub.destroy
    redirect_to subs_url

  end

  def sub_params
    params.require(:sub).permit(:title, :url, :description)
  end

end
