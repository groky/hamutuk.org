require 'spec_helper'

describe SessionsController do
  render_views
  
  describe "GET 'new'" do # test the show login form function
    it "should be successful" do
      get 'new'
      response.should be_success
    end
    
    it "should have the correct title" do
      get :new
      response.should have_selector("title", :content=>"Log in")
    end
  end #end login screen show

  describe "POST 'create'" do #test the sign in
    
    describe "invalid signin" do #invalid sign in
      before(:each) do
        @attr = {:email=>'mail@example.com', :password=>'invalid'}
      end
      
      it "should render the new page" do
        post :create, :session=>@attr
        response.should render_template(:new)
      end
      
      it "should have the correct title" do
        get :new
        response.should have_selector("title", :content=>"Log in")
      end
      
      it "should have a falsh.now message" do
        post :create, :session=>@attr
        flash.now[:error].should =~ /invalid/i
      end
    end #end invalid sign in
    
    describe "with valid email and password" do #valid signin
      
      before(:each) do
        @user = Factory(:user)
        @attr = { :email => @user.email, :password => @user.password }
      end
      
      it "should sign in the user" do
        post :create, :session => @attr
        #Tests for the sign in user
        controller.current_user.should == @user
        controller.should be_signed_in
      end
      
      it "should direct the user to the show pages" do
        post :create, :session => @attr
        @user.should_not be_nil
        response.should redirect_to( user_path(@user) )
      end
    end  #end valid signin
  end # test the sign in
  
  describe "DELETE 'destroy'" do #delete test
    
    it "should sign the user out" do
      test_sign_in(Factory(:user))
      delete :destroy
      controller.should_not be_signed_in
      response.should redirect_to(root_path)
    end
    
  end # end of delete test
end
