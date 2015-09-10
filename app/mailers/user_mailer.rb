class UserMailer < ApplicationMailer

  def new_user_notification(user)
    @user = user
    mail to: ENV['admin_email'], subject: "New BibleDrill.me user"
  end
end
