require 'rails_helper'

describe "highlights", type: :feature do

  let(:user) { FactoryGirl.create(:user, email: 'elijah@heaven.net', password: '12345678')}

  let!(:book) { FactoryGirl.create(:book)}
  let!(:chapter) { FactoryGirl.create(:chapter)}
  let!(:verse) { FactoryGirl.create(:verse)}

  context 'without a user' do

    before do
      allow_any_instance_of(Chapter).to receive(:prev){ chapter }
      allow_any_instance_of(Chapter).to receive(:next){ chapter }
    end

    it 'can highlight but not save', js: true do
      visit book_chapter_path(book_id: book.permalink, id: chapter.id)
      li = find("ol.verses").find("li:first-child")
      li.click
      expect(li).to have_css('.selected')
    end
  end

  context 'with a user' do
    before { user.confirm }
    it 'can highlight and save' do
      # visit book_chapter_path(book_id: 1, id: 1)
      # expect(current_path).to eq(edit_user_registration_path)
    end
  end

end