class UserController < ApplicationController
  
  before_filter :authenticate, :only => [:edit, :update]
  before_filter :correct_user, :only => [:edit, :update]
  
  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Congratulations on joining hamutuk.org!"
      redirect_to @user
    else
      @title = "Registration Failure"
      @user.password = ""
      types
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
    types
    @title = "Register"
  end
  
  def levels
    @levels = Levels.all
  end
  
  def types
    @types = UserTypes.all
  end
  
  def edit
    @user = User.find(params[:id])
    types
    @title = "Edit #{@user.username}"
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "#{@user.username}, your profile is updated."
      redirect_to @user
    else
      @title = "Edit #{@user.username}"
      render 'edit'
    end
  end
  
  private
    def authenticate
      deny_access unless signed_in?
    end
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

end
