require 'rails_helper'

describe "omniauth_callbacks", type: :feature do

  let(:user) { FactoryGirl.create(:user, email: 'elijah@heaven.net', password: '12345678')}

  context 'with valid user' do
    it 'loads the registration page' do
      user.confirm
      visit new_user_session_path
      fill_in :user_email, with: user.email
      fill_in :user_password, with: user.password
      click_button "Sign In"
      expect(current_path).to eq(edit_user_registration_path)
    end
  end

  context 'with invalid user' do
    it 'shows an error' do
      visit new_user_session_path
      fill_in :user_email, with: user.email
      fill_in :user_password, with: 'error'
      click_button "Sign In"
      expect(page).to have_content('Invalid Email')
    end
  end

end