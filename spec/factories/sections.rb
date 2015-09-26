FactoryGirl.define do
  factory :section do
    study nil
    title "MyString"
    notes "MyText"
    postion 0

    before(:create) do |s|
      s.verses << (Verse.first || FactoryGirl.create(:verse))
    end
  end

end
