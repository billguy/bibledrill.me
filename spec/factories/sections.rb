FactoryGirl.define do
  factory :section do
    study nil
    title "MyString"
    notes "MyText"

    before(:create) do |s|
      s.verses << (Verse.first || FactoryGirl.create(:verse))
    end
  end

end
