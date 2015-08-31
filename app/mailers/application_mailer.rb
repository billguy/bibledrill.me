class ApplicationMailer < ActionMailer::Base
  default from: APP_CONFIG['admin_email']
  layout 'mailer'
end
