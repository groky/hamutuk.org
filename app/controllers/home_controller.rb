class HomeController < ApplicationController
  def index
    @title="Welcome"
  end

  def about
    @title="About Us"
  end

  def contact
    @title="Contact Us"
  end

end
