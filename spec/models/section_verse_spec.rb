require 'rails_helper'

RSpec.describe SectionVerse, type: :model do
    it { is_expected.to belong_to(:verse)}
    it { is_expected.to belong_to(:section)}
end