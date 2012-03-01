module UserHelper
  def gravatar_for (user, options = {:size => 50})
    gravatar_image_tag(user.email.downcase, :alt => user.username, 
                                            :class => 'gravatar', 
                                            :gravatar => options)
  end
  
  def verified?(user)
    notice = "Please check your emails. You have not confirmed
    by clicking on the confirmation link in the email sent via the registration page"
    
    redirect_to verify_path, :notice => notice unless user.verified
  end
  
end
