require 'rails_helper'

RSpec.describe Section, type: :model do
  it { is_expected.to belong_to(:study)}
  it { is_expected.to have_many(:section_verses)}
  it { is_expected.to have_many(:verses).through(:section_verses)}
  it { is_expected.to accept_nested_attributes_for(:section_verses)}

end
