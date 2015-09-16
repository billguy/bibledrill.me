FactoryGirl.define do
  factory :chapter do
    before(:create) do |c|
      c.book = Book.first || FactoryGirl.create(:book)
    end
    number 1
  end

end
