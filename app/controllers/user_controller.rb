class UserController < ApplicationController
  
  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Congratulations on joining hamutuk.org!"
      redirect_to @user
    else
      @title = "Registration Failure"
      @user.password = ""
      render :register
    end
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def login
    @title = "Login"
  end

  def register
    @user = User.new
    @title = "Register"
  end

end
