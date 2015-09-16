require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to validate_uniqueness_of(:email)}
  it { is_expected.to validate_presence_of(:email)}
  it { is_expected.to have_attached_file(:avatar) }
  it { is_expected.to validate_attachment_content_type(:avatar).allowing('image/jpg', 'image/png') }
  it { is_expected.to callback(:notify_admin).after(:create) }
  it { is_expected.to have_many(:highlights)}

end