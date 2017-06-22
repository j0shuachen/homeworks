class UsersController < ApplicationController
  def index
    # render text: "I'm in the index action!"
    render json: User.all.pluck(:username)
  end

  # def create
  #   render json: params
  # end

  def show
    @user = finder
    if @user
      render json: @user
    else
      render json: ["Could not find user"], status: 404
    end
  end

  def update
    @user = finder
    if @user.update_attributes(user_params)
      render json: @user
    else
      render json: @user.errors.full_messages, status: 400
    end
  end

  def create
    p params
    user = User.new(user_params)
    # replace the `user_attributes_here` with the actual attribute keys
    if user.save
      render json: user
    else
      render(
      json: user.errors.full_messages, status: :unprocessable_entity
      )
    end
  end

  def destroy
    @user = finder
    if @user
      @user.destroy
      render json: @user
    else
      render json: ["You cannot delete what you cannot find."], status: 404
    end
  end


  private

  def user_params
    params.require(:user).permit(:username)
  end

  def finder
    User.find_by(id: params[:id])
  end
end
