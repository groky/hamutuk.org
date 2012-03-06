namespace :bootstrap do
  
  desc "Adding the default user_types"
  task :default_user_types => :environment do
    UserTypes.create( :name => 'INDIVIDUAL', :description => 'An individual user' )
    UserTypes.create( :name => 'ORGANISATION', 
                      :description => 'A company, business or other organisation' )
  end
  
  desc "Add the default levels"
  task :default_levels => :environment do
    Levels.create( :name => 'SUPER', :description => 'A godlike user' )
    Levels.create( :name => 'ADMIN', :description => 'An administrator' )
    Levels.create( :name => 'DONAR', :description => 'A donor' )
    Levels.create( :name => 'STUDENT', :description => 'A recipient of the funds' )
  end
  
  desc "Do all the defaults"
  task :all => [:default_user_types, :default_levels]
  
end