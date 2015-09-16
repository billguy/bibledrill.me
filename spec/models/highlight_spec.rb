require 'rails_helper'

RSpec.describe Highlight, type: :model do
  it { is_expected.to belong_to(:user)}
  it { is_expected.to belong_to(:verse)}
end
