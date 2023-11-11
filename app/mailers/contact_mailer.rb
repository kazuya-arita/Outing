class ContactMailer < ApplicationMailer
  
  def contact_mail(contact, user)
    mail to: user.email, bcc: ENV[ebiebi@ebi.com]
  end  
  
end
