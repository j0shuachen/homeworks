class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :signed_in?

  def current_user
    return nil if session[:session_token].nil?
    @current_user ||= User.find_by_session_token(session[:session_token])
  end

  def require_current_user
    redirect_to new_session_url unless signed_in?
  end

  def sign_in(user)
    @current_user = user
    session[:session_token] = user.session_token
  end

  def signed_in?
    !!current_user
    # if current_user
    #   return true
    # else
    #   return false
    # end
  end

  def sign_out
    current_user.try(:reset_token!)
    session[:session_token] = nil
  end


end
