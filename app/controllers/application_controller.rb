class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :current_user, :logged_in? #為了讓view可以使用這些function所以要成為helper_method
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]  #memorization
    #reture current user if current user is already exist (have already look for this user),
    # if not then :
    # check if user_id is save by browser in session hash. If so, find user in database base on this user id
    #
    # http://www.rubyinside.com/what-rubys-double-pipe-or-equals-really-does-5488.html
  end
  
  def logged_in?
    # convert anything in boolean : !!
    !!current_user  # if have curent user returns true, otherwise returns false
  end
  
  def require_user
    if !logged_in?
      flash[:danger] = "You must be logged in to perform that action"
      redirect_to root_path
    end
  end
end
