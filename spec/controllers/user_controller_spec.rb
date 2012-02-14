require 'spec_helper'

describe UserController do
  render_views
  
  #describe "GET 'show'" do
  #  it "should be successful" do
  #    get 'show'
  #    response.should be_success
  #  end
  #end
  
  describe "GET 'register'" do
    it "should be successful" do
      get :register
      
      response.should be_success
      
    end
  end 

  describe "POST 'create'" do
    describe "failure" do
      before(:each) do
        @attr = {:username => "", :email => "", :password => "",
                  :password_confirmation => ""}
      end
    
      it "should not create a user" do
        lambda do
          post :create, :user => @attr
        end.should_not change(User, :count)
      end
    
      it "should have the correct title" do
        post :create, :user => @attr
        response.should have_selector("title", :content => "Register")
      end
    
      it "should render the 'new page' template" do
        post :create, :user => @attr
        response.should render_template('register')
      end
    end
    
    describe "success" do
      before(:each) do
        @attr = {:username => "User Name", :email => "user@example.com",
                  :password => "foobar", :password_confirmation => "foobar"}
      end
      
      it "should create a user" do
        lambda do
          post :create, :user => @attr
        end.should change(User,:count).by(1)
      end
      
      it "should redirect to the show page" do
        post :create, :user => @attr
        response.should redirect_to(user_path(assigns(:user)))
      end
      
      it "should have a welcome message" do
        post :create, :user => @attr
        flash[:success].should =~ /congratulations on joining hamutuk.org!/i
      end
    end
  end
end
