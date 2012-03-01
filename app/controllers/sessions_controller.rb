class SessionsController < ApplicationController
  def new
    @title = "Log in"
  end
  
  def create
    #render :new
    user = User.authenticate(params[:session][:email],
                              params[:session][:password])
    @title = "Log in"
    
    if !user.nil? && !verified?(user)
      flash.now[:error] = "You have not verified your account. Please check your email and try again
                          or register"    
      render :new
    else
      if user.nil?
        # flash the error
        flash.now[:error] = "Invalid email/password combination"
        render :new
      else
        sign_in user
        redirect_back_or user
      end
    end
    
  end
  
  def destroy
    sign_out
    redirect_to root_path
  end

end
