class UserMailer < ApplicationMailer

  def new_user_notification(user)
    @user = user
    mail to: APP_CONFIG['admin_email'], subject: "New BibleDrill.me user"
  end
end
