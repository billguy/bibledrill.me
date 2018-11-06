FactoryBot.define do
  factory :verse do
    before(:create) do |v|
      v.chapter = Chapter.first || create(:chapter)
    end
    number {1}
    page {1}
    verse_cross_references_count {0}
    text {"In the beginning God created the heaven and the earth."}
  end

end
