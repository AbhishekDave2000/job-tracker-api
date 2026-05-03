source "https://rubygems.org"

# Gemfile
gem "dotenv-rails", groups: [ :development, :test ]  # ← must be BEFORE other gems

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
ruby "3.3.4"
gem "rails", "~> 8.1.2"
# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"
# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 6.0"
# Build JSON APIs with ease [https://github.com/rails/jbuilder]
# gem "jbuilder"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
gem "bcrypt", "~> 3.1.7"             # has_secure_password
gem "jwt", "~> 2.7"                   # JSON Web Tokens


gem "rack-cors"                        # Handle CORS
gem "active_model_serializers"         # JSON serialization

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Use the database-backed adapters for Rails.cache, Active Job, and Action Cable
gem "solid_cache"
gem "solid_queue"
gem "solid_cable"

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Deploy this application anywhere as a Docker container [https://kamal-deploy.org]
gem "kamal", require: false

# Add HTTP asset caching/compression and X-Sendfile acceleration to Puma [https://github.com/basecamp/thruster/]
gem "thruster", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
gem "image_processing", "~> 1.2"

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin Ajax possible
# gem "rack-cors"

group :development, :test do
  gem "rspec-rails", "~> 6.1"
  gem "factory_bot_rails"
  gem "faker"
  gem "pry-rails"
  gem "brakeman", require: false
  gem "bundler-audit", require: false
  gem "rubocop", require: false
  gem "rubocop-rails-omakase", require: false
end

group :development do
  gem "rubocop-rails", require: false
end

group :test do
  gem "shoulda-matchers"
  gem "database_cleaner-active_record"
end
