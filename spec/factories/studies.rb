FactoryGirl.define do
  factory :study do
    active false
    user nil
    title "MyString"
    permalink "test"
    description "MyText"
    cached_votes_total 0
    cached_votes_score 0
    cached_votes_up 0
    cached_votes_down 0
    cached_weighted_score 0
    cached_weighted_total 0
    cached_weighted_average 0.0

    before(:create) do |s|
      s.sections << FactoryGirl.create(:section, study: s)
    end
  end

end
