require 'rails_helper'

describe "omniauth_callbacks", type: :feature do

  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
    provider: 'facebook',
    uid: '123545',
    "info" => {
      "name" => "Elijah the Tishbite",
      "image" => "http://loremflickr.com/320/240",
      "email" => "elijah@heaven.net"
    }
  })

  before do
    Rails.application.env_config["devise.mapping"] = Devise.mappings[:user]
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
  end

  context 'with facebook' do
    context 'when valid' do
      it 'can create a new user' do
        visit user_omniauth_authorize_path(provider: :facebook)
        expect(page).to have_content('You have to confirm your email address')
        user = User.last
        expect(user.name).to eq "Elijah the Tishbite"
        expect(user.email).to eq "elijah@heaven.net"
        expect(user.avatar).to be_exists
      end
    end

    context 'when invalid' do
      it 'returns an error' do
        OmniAuth.config.mock_auth[:facebook] = :invalid_credentials
        visit user_omniauth_authorize_path(provider: :facebook)
        expect(page).to have_content('Could not authenticate you')
      end
    end
  end

end