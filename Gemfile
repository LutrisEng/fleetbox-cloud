# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.2'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 7.0.3'

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem 'sprockets-rails', '~> 3.4.2'

# Use PostgreSQL as the database for Active Record [https://github.com/ged/ruby-pg]
gem 'pg', '~> 1.4.1'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '~> 5.6.4'

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem 'importmap-rails', '~> 1.1.2'

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
# gem 'turbo-rails', '~> 1.1.1'

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem 'stimulus-rails', '~> 1.0.4'

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem 'jbuilder', '~> 2.11.5'

# Use Redis adapter to run Action Cable in production [https://github.com/redis/redis-rb]
gem 'redis', '~> 4.7.0'

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
gem 'kredis', '~> 1.2.0'

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem [https://tzinfo.github.io/]
gem 'tzinfo-data', '~> 1.2022.1', platforms: %i[mingw mswin x64_mingw jruby]

# Reduces boot times through caching; required in config/boot.rb [https://github.com/Shopify/bootsnap]
gem 'bootsnap', '~> 1.12.0', require: false

# Use Sass to process CSS [https://github.com/sass/sassc-rails]
gem 'sassc-rails', '~> 2.1.2'

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
gem 'image_processing', '~> 1.12.2'

# Use Omniauth for authentication [https://github.com/omniauth/omniauth]
gem 'omniauth', '~> 2.1.0'
gem 'omniauth-auth0', '~> 3.0.0'
gem 'omniauth-rails_csrf_protection', '~> 1.0.1'

# Use Pundit for authorization [https://github.com/varvet/pundit]
gem 'pundit', '~> 2.2.0'

# Use Bootstrap's CSS and JavaScript for the frontend [https://getbootstrap.com/]
gem 'bootstrap', '~> 5.1.3'
gem 'bootstrap_form', '~> 5.1.0'

# Use the AWS SDK to talk to R2 [https://github.com/aws/aws-sdk-ruby]
gem 'aws-sdk-s3', '~> 1.114.0', require: false

# Use GoodJob as an ActiveJob backend [https://github.com/bensheldon/good_job]
gem 'good_job', '~> 3.0.0'

# Use ViewComponent to create composable front-end components [https://github.com/github/view_component]
gem 'view_component', '~> 2.57.1'

# Use Lookbook to preview ViewComponents, much like Storybook [https://github.com/allmarkedup/lookbook]
gem 'lookbook', '~> 0.9.1'

# Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
gem 'memory_profiler', '~> 1.0.0'
gem 'rack-mini-profiler', '~> 3.0.0'
gem 'stackprof', '~> 0.2.19'

# Add an admin dashboard [https://activeadmin.info/]
gem 'activeadmin', '~> 2.13.1'

# Compile Markdown to HTML [https://kramdown.gettalong.org/]
gem 'kramdown', '~> 2.4.0'

# Use Sentry to track errors [https://sentry.io]
gem 'sentry-rails', '~> 5.3.1'
gem 'sentry-ruby', '~> 5.3.1'

# Use New Relic to keep track of performance [https://newrelic.com]
gem 'newrelic_rpm', '~> 8.8.0'

# Report on N+1 queries to improve optimization [https://github.com/flyerhzm/bullet]
gem 'bullet', '~> 7.0.2'

# Use the graphql gem to expose a GraphQL API [https://graphql-ruby.org/]
gem 'graphiql-rails', '~> 1.8.0'
gem 'graphql', '~> 2.0.11'

group :development, :test do
  # Add debugging support [https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem]
  gem 'debug', '~> 1.5.0', platforms: %i[mri mingw x64_mingw]
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem 'web-console', '~> 4.2.0'

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  gem 'spring', '~> 4.0.0'

  # Lint code with Rubocop [https://rubocop.org/]
  gem 'erb_lint', '~> 0.1.3', require: false
  gem 'rubocop', '~> 1.31.1', require: false
  gem 'rubocop-rails', '~> 2.15.1', require: false

  # Use Pry as Rails console [http://pry.github.io/]
  gem 'pry', '~> 0.14.1'
  gem 'pry-rails', '~> 0.3.9'

  # Include Solargraph for VSCode integration [https://solargraph.org/]
  gem 'solargraph', '~> 0.45.0', require: false
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem 'capybara', '~> 3.37.1'
  gem 'selenium', '~> 0.2.11'
  gem 'selenium-webdriver', '~> 4.3.0'
  # gem 'webdrivers', '~> 5.0.0'

  # Perform performance testing [https://github.com/ruby/benchmark]
  gem 'benchmark', '~> 0.2.0'

  # Run Active Record validations on fixtures [https://github.com/dafalcon/fixture_validation]
  gem 'fixture_validation', '~> 0.2'

  # Export JUnit test results for ingest to GitHub Actions [https://github.com/aespinosa/minitest-junit]
  gem 'minitest-junit', '~> 1.1.0'
end
