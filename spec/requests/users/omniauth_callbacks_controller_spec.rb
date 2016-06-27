require 'rails_helper'

describe Users::OmniauthCallbacksController do

  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
    provider: 'facebook',
    uid: '123545',
    "info" => {
      "name" => "Elijah the Tishbite",
      "image" => "https://placeholdit.imgix.net/~text?txtsize=33&txt=300%C3%97300&w=300&h=300",
      "email" => "elijah@heaven.net"
    }
  })

  before do
    Rails.application.env_config["devise.mapping"] = Devise.mappings[:user]
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
  end

  describe '#authorize', focus: true do
    it "works with facebook" do
      get user_facebook_omniauth_authorize_path
      expect(response.status).to eq(302)
    end
  end

  describe '#callback' do
    it "works with facebook" do
      get user_facebook_omniauth_callback_path
      expect(response.status).to eq(302)
    end
  end

end