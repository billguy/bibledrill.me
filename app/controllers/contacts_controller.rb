require "recaptcha/rails"

class ContactsController < ApplicationController
  def index

  end

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    verified = verify_recaptcha(model: @contact, secret_key: ENV['recaptcha_private_key'])
    if @contact.valid? && verified
      ContactMailer.new_contact(@contact).deliver_now
      redirect_to root_path, notice: "Thanks for your message."
    else
      flash_now!(:error) if verified
      render :new
    end
  end

  private

    def contact_params
      params.require(:contacts).permit(:name, :email, :message)
    end
end