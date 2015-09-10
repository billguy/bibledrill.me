require "rails_helper"

RSpec.describe ContactMailer, type: :mailer do
  describe "new_contact" do
    let(:contact) { FactoryGirl.build(:contact) }
    let(:mail) { ContactMailer.new_contact(contact) }

    it "renders the headers" do
      expect(mail.subject).to eq("BibleDrill.me contact form submission")
      expect(mail.to).to eq([ENV['admin_email']])
      expect(mail.from).to eq([ENV['admin_email']])
      expect(mail.reply_to).to eq([contact.email])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match(contact.message)
    end
  end

end
