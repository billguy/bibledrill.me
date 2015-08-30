class Users::SessionsController < Devise::SessionsController

  def new
    store_location_for(resource_name, request.referer) unless stored_location_for(resource_name)
    super
  end

end