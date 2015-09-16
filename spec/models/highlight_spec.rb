require 'rails_helper'

RSpec.describe Highlight, type: :model do
  it { is_expected.to belong_to(:user)}
  it { is_expected.to belong_to(:verse)}
  it { is_expected.to validate_presence_of(:verse)}
  it { is_expected.to validate_presence_of(:user)}
  it { is_expected.to validate_uniqueness_of(:verse).scope(:user)}
end
