require 'rails_helper'

describe Users::OmniauthCallbacksController do

  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
    provider: 'facebook',
    uid: '123545',
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

  describe '#authorize', focus: true do
    it "works with facebook" do
      get user_omniauth_authorize_path(:facebook)
      expect(response.status).to eq(302)
    end
  end

  describe '#callback' do
    it "works with facebook" do
      get user_omniauth_callback_path(action: :facebook)
      expect(response.status).to eq(302)
    end
  end

end