Raygun.setup do |config|
  config.api_key = ENV['RAYGUN_APIKEY']
  config.filter_parameters = Rails.application.config.filter_parameters

  config.ignore  << ['ActionController::BadRequest', 'ActionView::MissingTemplate']

  # The default is Rails.env.production?
  # config.enable_reporting = !Rails.env.development? && !Rails.env.test?
end
