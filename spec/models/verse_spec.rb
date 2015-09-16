require 'rails_helper'

RSpec.describe Verse, type: :model do
  it { is_expected.to have_many(:highlights)}
end
