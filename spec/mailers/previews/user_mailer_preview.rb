# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/new_user_notification
  def new_user_notification
    user = build(:user)
    UserMailer.new_user_notification(user)
  end

end
