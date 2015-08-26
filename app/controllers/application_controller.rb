class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || main_app.edit_user_registration_path
  end

  def after_sign_up_path_for(resource)
    root_path
  end

  def after_inactive_sign_up_path_for(resource)
    root_path
  end

  def after_confirmation_path_for(resource_name, resource)
    root_path
  end

end
