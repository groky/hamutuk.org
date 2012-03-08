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
        response.should have_selector("title", :content => "Registration Failure")
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
      
      it "should have verified==false" do
        lambda do
          post :create, :user => @attr
          User.verified.should be_false
        end
      end
      
      it "should render to the verify page" do
        post :create, :user => @attr
        flash[:success].should =~ /Please check your email and verify by clicking the link!/i
      end
      
      it "should have a welcome message" do
        post :create, :user => @attr
        flash[:success].should =~ /Please check your email and verify by clicking the link!/i
      end
      
      #it "should sign the user in" do
      #  post :create , :user => @attr
      #  controller.should be_signed_in
      #end
      
      it "should send an email" do
        post :create, :user => @attr
        
      end
      
    end
    
    describe "GET 'edit'" do #test the edit stuff
      
      before(:each) do
        @user = Factory(:user)
        test_sign_in(@user)
      end
      
      it "should be successful" do
        get :edit, :id => @user
        response.should be_success
      end
      
      it "should have the right title" do
        get :edit, :id => @user
        response.should have_selector("title", :content=>"Edit #{@user.username}")
      end
      
      it "should have a link to change the gravatar" do
        get :edit, :id=>@user
        gravatar_url = "http://gravatar.com/emails"
        response.should have_selector("a", :href => gravatar_url,
                                            :content => "change")
      end
      
    end # end edit test
    
    describe "PUT 'update'" do # the update test
      
      before(:each) do
        @user = Factory(:user)
        test_sign_in(@user)
      end
      
      describe "failure" do # failure test
        
        before(:each) do
          @attr = {:email => "", :username => "", :password=>"",
                  :password_confirmation=>""}
        end
        
        it "should render the 'edit' page" do
          put :update, :id => @user, :user => @attr
          response.should have_errors unless @user.nil?
          #response.should render_template('edit')
        end
        
        it "should have the correct title" do
          put :update, :id => @user, :user => @attr
          response.should have_selector("title", :content=>"Edit #{@user.username}")
        end
      end # end failure test
      
      describe "success" do # the success test
        before(:each) do
          @attr = { :username => "New Name", :email => "user@example.org",
                    :password => "barbaz", :password_confirmation => "barbaz" }
        end

        it "should change the user's attributes" do
          put :update, :id => @user, :user => @attr
          @user.reload
          @user.username.should  == @attr[:username]
          @user.email.should == @attr[:email]
        end

        it "should redirect to the user show page" do
          put :update, :id => @user, :user => @attr
          response.should redirect_to(user_path(@user))
        end

        it "should have a flash message" do
          put :update, :id => @user, :user => @attr
          flash[:success].should =~ /updated/
        end
      end #end of success test
      
    end #end the update test
    
    describe "authentication of edit/update pages" do #authentication test
      
      before(:each) do
        @user = Factory(:user)
      end
      
      describe "for non-signed-in users" do # non-signed in test
        
        it "should deny access to 'edit'" do
          get :edit, :id => @user
          response.should redirect_to(login_path)
        end
        
        it "should deny access to 'update'" do
          put :update, :id => @user
          response.should redirect_to(login_path)
        end
        
      end # end non-signed in test
      
      describe "for signed-in users" do

        before(:each) do
          wrong_user = Factory(:user, :email => "user@example.net")
          test_sign_in(wrong_user)
        end

        it "should require matching users for 'edit'" do
          get :edit, :id => @user
          response.should redirect_to(root_path)
        end

        it "should require matching users for 'update'" do
          put :update, :id => @user, :user => {}
          response.should redirect_to(root_path)
        end
      end
    end # end authentication test
  end
end
