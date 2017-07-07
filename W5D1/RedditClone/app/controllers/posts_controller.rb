class PostsController < ApplicationController

  before_action :require_current_user, except: [:show]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    if @post.save
      redirect post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def show
    @post = Post.find_by(id: params[:id])
  end

  def edit
    @post = current_user.posts.find_by(id: params[:id])
    if @post
      # @post = Post.find(params[:id])
      render :edit
    else
      flash[:errors] = ["not your post!"]
      redirect_to posts_url
    end
  end

  def update
    @post = current_user.posts.find_by(id: params[:id])

    if @post.update_attributes(post_params)
      redirect post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def destroy
    @post = current_user.posts.find_by(id: params[:id])
    @post.destroy
    redirect_to posts_url
  end

  def post_params
    params.require(:post).permit(:title, :url, :content, :user_id, sub_ids:[])
  end
end
