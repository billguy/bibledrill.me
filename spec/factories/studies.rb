FactoryGirl.define do
  factory :study do
    active false
    user nil
    title "MyString"
    permalink "test"
    description "MyText"

    before(:create) do |s|
      s.sections << FactoryGirl.create(:section, study: s)
    end
  end

end
