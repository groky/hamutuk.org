require 'emailer'
class UserController < ApplicationController
  
  before_filter :authenticate, :only => [:edit, :update]
  before_filter :correct_user, :only => [:edit, :update]
  
  def create
    @user = User.new(params[:user])
    if @user.save
      #sign_in @user
      _email(@user)
      flash[:success] = "Please check your email and verify by clicking the link!"
      render :verify
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
  
  def verify
    @user = User.find_by_confirmation_hash(params[:hsh])
    
    @user.verified=true unless user.nil?
    if @user.save 
      flash[:success] = "Congratulations on joining hamutuk.org!"
      @title = "#{@user.username} verified. Welcome"
      redirect_to @user
    else
      flash[:failure] = "There has been a problem. You could not be verified. Please check your email
      and try again"
      @title = "Verification failure"
      render :verify
    end
    
  end
  
  def levels
    @levels = Levels.all
  end
  
  def types
    @types = UserTypes.all
  end
  
  private
    def authenticate
      deny_access unless signed_in?
    end
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
    
    def verification
      deny_access unless verified?
    end
    
    def _email(user)
      #link = "#{root_url}/users/verify/?hsh=#{@user.confirmation_hash}"
      #puts link
      #then send the email
      Emailer.sendmail(user, "Hamutuk Registration").deliver
    end

end
