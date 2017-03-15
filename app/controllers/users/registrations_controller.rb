class Users::RegistrationsController < Devise::RegistrationsController

  before_action :configure_permitted_parameters

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up).try(:keys, :name, :website, :bio, :avatar, :time_zone)
    devise_parameter_sanitizer.permit(:account_update).try(:keys, :name, :website, :bio, :avatar, :time_zone)
  end

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

end