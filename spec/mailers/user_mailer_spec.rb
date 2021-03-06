require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe "new_user_notification" do
    let(:user) { build(:user) }
    let(:mail) { UserMailer.new_user_notification(user) }

    it "renders the headers" do
      expect(mail.subject).to eq("New BibleDrill.me user")
      expect(mail.to).to eq([ENV['admin_email']])
      expect(mail.from).to eq([ENV['admin_email']])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match(user.name)
    end
  end

end
