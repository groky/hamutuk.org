require 'rubygems'
require 'spork'

Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'
  unless defined?(Rails)
    require File.dirname(__FILE__) + "/../config/environment"
  end
  require 'rspec/rails'
  
  Dir["#{File.dirname{__FILE__}}/support/**/*.rb"].each {|f| require f}
  
  Rspec.configure do |config|
    config.mock_with :rspec
    
    config.fixture_path ="#{::Rails.root}/spec/fixtures"
    
    config.user_transactional_fixtures = true
    
    ActiveSupport::Dependencies.clear
  end
end

Spork.each_run do
end