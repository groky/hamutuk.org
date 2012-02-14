require 'spec_helper'

describe HomeController do
  render_views
  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
    
    it "should have the correct title" do
      get :index
      response.should have_selector("title", :content => "Welcome")
    end
  end

  describe "GET 'about'" do
    it "should be successful" do
      get :about
      response.should be_success
    end
    
    it "should have the correct title" do
      get :about
      response.should have_selector("title", :content => "About Us")
    end
  end

  describe "GET 'contact'" do
    it "should be successful" do
      get :contact
      response.should be_success
    end
    
    it "should have the correct title" do
      get :contact
      response.should have_selector("title", :content => "Contact Us")
    end
  end

end
