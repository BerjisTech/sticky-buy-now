class ApplicationMailer < ActionMailer::Base
  default from: 'Chris Norton <chris@websiteondemand.ca>',
          reply_to: 'support@websiteondemand.ca'
  layout 'mailer'
end
