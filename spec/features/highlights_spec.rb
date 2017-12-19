require 'rails_helper'

describe "highlights", type: :feature do

  let(:user) { create(:user, email: 'elijah@heaven.net', password: '12345678')}

  let!(:book) { create(:book)}
  let!(:chapter) { create(:chapter)}
  let!(:verse) { create(:verse)}

  context 'without a user' do

    before do
      allow_any_instance_of(Chapter).to receive(:prev){ chapter }
      allow_any_instance_of(Chapter).to receive(:next){ chapter }
    end

    it 'can highlight but not save', js: true, focus: true do
      visit book_chapter_path(book_id: book.permalink, id: chapter.id)
      span = find("ol.verses").find("li:first-child span.verse")
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
      login_as(user, scope: :user)
      allow_any_instance_of(Chapter).to receive(:prev){ chapter }
      allow_any_instance_of(Chapter).to receive(:next){ chapter }
    end

    it 'can highlight and save', js: true do
      visit book_chapter_path(book_id: book.permalink, id: chapter.id)
      span = find("ol.verses").find("li:first-child span.verse")
      span.click
      wait_for_ajax
      expect(span[:class]).to match('selected')
      visit current_path #reload the page
      expect(span[:class]).to match('selected')
    end
  end

end