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
      span = find("ol.verses").find("li:first-child span")
      span.click
      wait_for_ajax
      expect(span[:class]).to match('selected')
      visit current_path #reload the page
      expect(span[:class]).to_not match('selected')
    end
  end

  context 'with a user' do

    before do
      user.confirm
      allow_any_instance_of(Chapter).to receive(:prev){ chapter }
      allow_any_instance_of(Chapter).to receive(:next){ chapter }
    end

    it 'can highlight and save', js: true, focus: true do
      visit book_chapter_path(book_id: book.permalink, id: chapter.id)
      span = find("ol.verses").find("li:first-child span")
      p Highlight.count
      span.click
      wait_for_ajax
      p Highlight.count
      expect(span[:class]).to match('selected')
      visit current_path #reload the page
      expect(span[:class]).to match('selected')
    end
  end

end