require 'rails_helper'

describe "studies", type: :feature do

  let(:user) { User.find_by_email('elijah@heaven.net') || FactoryGirl.create(:user, email: 'elijah@heaven.net', password: '12345678')}

  context 'when not logged in' do
    it 'cannot create studies' do
      visit new_study_path
      expect(page).to have_content("You are not authorized to access this page")
    end
    it 'cannot edit studies' do
      study = FactoryGirl.create(:study)
      visit edit_study_path(study)
      expect(page).to have_content("You are not authorized to access this page")
    end
  end

  context 'with a logged in user', js: true do

    before do
      user.confirm
      login_as(user, scope: :user)
      allow_any_instance_of(Chapter).to receive(:prev){ chapter }
      allow_any_instance_of(Chapter).to receive(:next){ chapter }
    end

    # setup the bible so there's something to use in the tests
    let!(:book) { FactoryGirl.create(:book)}
    let!(:chapter) { FactoryGirl.create(:chapter)}
    let!(:verse) { FactoryGirl.create(:verse)}

    context 'when creating a study' do
      it 'can create' do
        visit new_study_path
        fill_in :study_title, with: 'Title'
        first('textarea#study_description', visible: false).set("Description") # hidden by summernote

        fill_in :study_sections_attributes_0_title, with: 'Title'
        first('textarea#study_sections_attributes_0_notes', visible: false).set("Description") # hidden by summernote
        first('a.load-bible').click
        within '#bible-modal' do # add verse
          click_link('Genesis')
          click_link('1')
          find("li[data-verse-id='1']").click
          first("button[data-dismiss='modal']").click
        end
        expect(page).to have_content('Genesis 1:1')
        expect(page).to have_content('In the beginning God created the heaven and the earth.')
        click_button 'Create Study'
        expect(page).to have_content('Genesis 1:1')
      end
    end

    context 'when updating a study', focus: true do

      let!(:study) { FactoryGirl.create(:study, user: user)}

      it 'can update' do
        visit edit_study_path(id: study.permalink)
        find("a.remove-verse[data-verse-id='1']").click # remove verse
        expect(page).to_not have_content('Genesis 1:1')
        expect(page).to_not have_content('In the beginning God created the heaven and the earth.')
        click_button 'Update Study'
        expect(page).to_not have_content('Genesis 1:1')
      end
    end

  end

end