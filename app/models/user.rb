class User < ActiveRecord::Base
  attr_accessible :email, :username, :password
  
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
  
  def has_password?(submitted_password)
    password == encrypt(submitted_password)
  end
  
  def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    return nil if user.nil?
    return user if user.has_password?(submitted_password)
  end
  
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
end
