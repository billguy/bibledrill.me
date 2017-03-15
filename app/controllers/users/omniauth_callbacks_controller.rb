class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  skip_before_action :verify_authenticity_token

  def facebook
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.persisted?
      if @user.active?
        sign_in_and_redirect @user, event: :authentication
        set_flash_message(:notice, :success, kind: "Facebook") if is_navigational_format?
      else
        redirect_to(new_user_session_path, flash: :inactive)
      end
    elsif @user.valid?
      @user.save!
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      store_location_for(@user, edit_user_registration_url)
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: "Facebook") if is_navigational_format?
    else
      redirect_to(new_user_session_path, flash: :account_unavailable)
    end
  end
end