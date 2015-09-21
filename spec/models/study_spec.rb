require 'rails_helper'

RSpec.describe Study, type: :model do
  it { is_expected.to have_many(:sections)}
  it { is_expected.to belong_to(:user)}
  it { is_expected.to accept_nested_attributes_for(:sections)}
  it { is_expected.to validate_presence_of(:title)}
  it { is_expected.to validate_presence_of(:description)}
end
