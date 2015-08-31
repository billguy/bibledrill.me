class ContactMailer < ApplicationMailer

  def new_contact(contact)
    @contact = contact
    mail to: APP_CONFIG['admin_email'], reply_to: @contact.email, subject: "BibleDrill.me contact form submission"
  end
end
