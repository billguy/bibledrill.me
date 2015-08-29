class Users::SessionsController < Devise::SessionsController

  def new
    store_location_for(resource_name, request.referer)
    super
  end

end