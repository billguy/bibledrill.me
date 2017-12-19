source 'https://rubygems.org'
ruby '2.4.1'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '5.1.4'
gem 'pg', group: :production
gem 'fog', group: :production
gem 'rails_12factor', group: :production # 4 heroku
gem 'raygun4ruby'
gem 'puma'
gem 'bootstrap-sass', '~> 3.3.7'
gem 'sass-rails', '~> 5.0.7'
gem 'uglifier', '>= 1.3.0'
gem 'therubyracer', platforms: :ruby
gem 'jquery-rails'
gem 'jbuilder', '~> 2.5'
gem 'slim-rails'
gem 'redis-rails'
gem "breadcrumbs_on_rails"
gem 'meta-tags'
gem 'stickykit-rails'
gem 'devise', github: 'plataformatec/devise'
gem 'cancancan'
gem 'omniauth-facebook', github: 'mkdynamic/omniauth-facebook'
gem 'paperclip'
gem "bootstrap_flash_messages", github: 'RobinBrouwer/bootstrap_flash_messages'
gem 'simple_form'
gem 'leaderboard'
gem 'delayed_job_active_record'
gem "recaptcha", :require => "recaptcha/rails"
gem 'valid_email', require: false
gem 'sendgrid-rails'
gem 'kaminari-bootstrap'
gem "cocoon"
gem "has_permalink"
gem "font-awesome-rails"
gem 'summernote-rails'
gem 'pg_search'
gem 'acts_as_votable'
gem 'impressionist'
gem 'social-share-button'
gem 'fitvidsjs_rails'

group :development do
  gem 'rack-mini-profiler'
  gem 'render_anywhere', require: false
  gem 'listen'
end

group :development, :test do
  gem 'sqlite3'
  gem 'rspec-rails', '~> 3.0'
  gem 'factory_bot_rails'
end

group :test do
  gem 'database_cleaner'
  gem 'capybara'
  gem "capybara-webkit"
  gem 'shoulda-matchers'
  gem 'shoulda-callback-matchers'
end