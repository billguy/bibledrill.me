require 'spec_helper'

describe Contact do

  it { is_expected.to respond_to(:name) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to respond_to(:email) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to respond_to(:message) }
  it { is_expected.to validate_presence_of(:message) }

  it "validates email is an email" do
    valid_email = build(:contact)
    invalid_email = build(:contact, email: "invalid")
    expect(valid_email).to be_valid
    expect(invalid_email).to_not be_valid
  end

end