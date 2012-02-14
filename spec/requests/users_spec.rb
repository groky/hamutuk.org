require 'spec_helper'

describe "Users" do
  
  describe "Signup" do
    describe "failure" do # start the failure test
      
      # fill in the form and check if there is a new user created
      # this should fail
      it "should not make a new user" do
        lambda do
          visit register_path
        
          fill_in "Name",         :with => ""
          fill_in "Email",        :with => ""
          fill_in "Password",     :with => ""
          fill_in "Confirmation", :with => ""
        
          click_button #submit the form
          response.should render_template('users/register')
          response.should have_selector("div#error_explanation")
          #response.should have_selector("")
        end.should_not change(User, :count)
      end
    
    end #end of failure test
    
    describe "success" do # start the success test
      
      # fill in the form and check if there is a new user created
      # this should pass
      it "should not make a new user" do
        lambda do
          visit register_path
        
          fill_in "Name",         :with => "User Name"
          fill_in "Email",        :with => "mail@mailer.com"
          fill_in "Password",     :with => "password"
          fill_in "Confirmation", :with => "password"
        
          click_button #submit the form
          response.should render_template('users/show')
          response.should_not have_selector("div#error_explanation")
        end.should change(User, :count).by(1)
      end
    
    end # end of success test
  end
end
