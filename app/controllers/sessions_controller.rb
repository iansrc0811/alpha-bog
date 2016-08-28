class SessionsController < ApplicationController
  
  def new
  
  end
  
  def create # 'create' at here means 'log in' not create an user
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id #save user_id in session, it will stored by the browser
      flash[:success] = "You have successfully logged in"
      redirect_to user_path(user)
    else
      flash.now[:danger] = "There was something wrong with your login information"  
      #flash: 每次重新更新都會出現 flash.now不會
      render 'new'
    end
  end
  
  def destroy
    session[:user_id] = nil
    flash[:success] = "You have logged out"
    redirect_to root_path
  end
  

end