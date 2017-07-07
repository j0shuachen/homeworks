class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by_credentials(params[:user][:username], params[:user][:password])

    if @user
      sign_in(@user)
      redirect_to "/subs"
    else
      flash[:errors] = ["something"]
      render :new
    end
  end


  def destroy
    sign_out
    render :new
  end
end
