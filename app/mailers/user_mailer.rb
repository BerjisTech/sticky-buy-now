class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.install_email.subject
  #
  def install_email(email_address, first_name)
    @greeting = first_name
    mail to: [email_address], subject: "Thanks for Installing Sticky Buy Button"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.uninstall_email.subject
  #
  def uninstall_email(email_address, first_name)
    @greeting = first_name
    mail to: email_address, subject: "Let us make it right - here's 30 days free of Sticky Buy Button on us"
  end
  
  def support_request(message, email)
    @message = message
    mail to: ENV['SUPPORT_EMAIL'], subject: "Sticky Buy Now Button Support Request", reply_to: email
  end
  
  def data_request(message, email)
    @message = message
    mail to: ENV['SUPPORT_EMAIL'], subject: "Customer Data Request for Sticky Buy Now Button App", reply_to: email
  end     
  
end
