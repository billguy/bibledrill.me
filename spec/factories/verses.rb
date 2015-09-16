FactoryGirl.define do
  factory :verse do
    before(:create) do |v|
      v.chapter = Chapter.first || FactoryGirl.create(:chapter)
    end
    number 1
    page 1
    text "In the beginning God created the heaven and the earth."
  end

end
