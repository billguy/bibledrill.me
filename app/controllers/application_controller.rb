class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end

  protected

  def after_sign_in_path_for(resource)
    if resource.is_a?(User) && !resource.active?
      sign_out resource
      flash[:error] = "Your account is not active"
      new_user_session_path
    else
      stored_location_for(resource) || edit_user_registration_path
    end
  end

  def after_sign_out_path_for(resource)
    stored_location_for(resource) || request.referer || root_path
  end

  def after_sign_up_path_for(resource)
    edit_user_registration_path
  end

  def after_inactive_sign_up_path_for(resource)
    root_path
  end

  def after_confirmation_path_for(resource_name, resource)
    root_path
  end

end
