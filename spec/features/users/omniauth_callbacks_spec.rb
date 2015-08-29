require 'rails_helper'

describe "omniauth_callbacks", type: :feature do

  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
    provider: 'facebook',
    uid: '12345',
    "info" => {
      "name" => "Elijah the Tishbite",
      "image" => "https://dummyimage.com/300",
      "email" => "elijah@heaven.net"
    }
  })

  before do
    Rails.application.env_config["devise.mapping"] = Devise.mappings[:user]
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
  end

  describe 'facebook' do

    context 'with valid credentials' do
      it 'creates a new user' do
        visit user_omniauth_authorize_path(provider: :facebook)
        expect(current_path).to eq(edit_user_registration_path)
        expect(page).to have_content('Successfully authenticated')
        user = User.last
        expect(user.name).to eq "Elijah the Tishbite"
        expect(user.email).to eq "elijah@heaven.net"
        expect(user.avatar).to be_exists
      end

      context 'when user is deactivated', focus: true do
        it 'does not allow login' do
          user = FactoryGirl.create(:user, provider: 'facebook', uid: '12345', active: false)
          visit user_omniauth_authorize_path(provider: :facebook)
          expect(current_path).to eq(new_user_session_path)
          expect(page).to have_content('Account Unavailable')
        end
      end
    end

    context 'with invalid credentials' do
      it 'returns an error' do
        OmniAuth.config.mock_auth[:facebook] = :invalid_credentials
        visit user_omniauth_authorize_path(provider: :facebook)
        expect(page).to have_content('Could not authenticate you')
      end
    end

  end

end