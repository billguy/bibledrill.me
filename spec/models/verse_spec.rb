require 'rails_helper'

RSpec.describe Verse, type: :model do
  it { is_expected.to have_many(:highlights)}
  it { is_expected.to have_many(:section_verses)}
  it { is_expected.to have_many(:sections).through(:section_verses)}
  it { is_expected.to have_many(:studies).through(:sections)}
end
