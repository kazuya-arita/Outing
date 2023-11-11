class ContactMailer < ApplicationMailer
  
  def contact_mail(contact, user)
    mail to: user.email, bcc: ENV['SEND_MAIL'], subject: "お問い合わせについて【自動送信】"
  end  
  
end
