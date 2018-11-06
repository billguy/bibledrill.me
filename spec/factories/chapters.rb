FactoryBot.define do
  factory :chapter do
    before(:create) do |c|
      c.book = Book.first || create(:book)
    end
    number {1}
  end

end
