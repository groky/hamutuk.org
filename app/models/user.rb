class User < ActiveRecord::Base
  attr_accessible :email, :username, :password, :type_id, :level_id, :verified, 
                  :confirmation_hash
  
  # not sure if these two lines are necessary, but added them for documentation nonetheless
  belongs_to :levels, :foreign_key=>:level_id
  belongs_to :usertypes, :foreign_key=>:type_id
  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :username, :presence => true
  
  validates :email, :presence => true, 
            :format => { :with => email_regex },
            :uniqueness => {:case_sensitive => false}
            
  validates :password, 
            :presence => true,
            :confirmation => true, 
            :length => {:minimum => 6}
  
  validates_confirmation_of :password
            
  before_save :encrypt_password
  before_save :generate_hash unless :verified==true
  
  def has_password?(submitted_password)
    password == encrypt(submitted_password)
  end
  
  def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    return nil if user.nil?
    return user if user.has_password?(submitted_password)
  end
  
  def self.authenticate_with_pwsalt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.pwsalt == cookie_salt) ? user : nil
  end
  
  #these are all the levels
  #def levels
  #  Levels.all
  #end
  
  # these are all the user types
  #def types
  #  UserTypes.all
  #end
  private
    def encrypt_password
      self.pwsalt = make_salt if new_record?
      self.password = encrypt(password)
    end
    
    def encrypt(string)
      secure_hash("#{pwsalt}--#{string}")
    end
    
    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end
    
    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end
    
    def generate_hash
      self.confirmation_hash = secure_hash("#{Time.now.utc}--#{self.email}")
    end
end
