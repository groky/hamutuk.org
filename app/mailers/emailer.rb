class Emailer < ActionMailer::Base
  default :from => "info@hamutuk.org"
  
  
  def sendmail(user, subj, url)
      @user = user
      @url  = url
      mail(:to => user.email, :subject => subj)
      render :text => 'Message sent successfully'
  end
end
