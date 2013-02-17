source 'https://rubygems.org'

gem 'rails', '3.2.12'

# Gems used only for assets and not required
# in production environments by default.
gem 'jquery-rails'
gem 'simple_form'
gem "high_voltage"
gem 'bcrypt-ruby'

gem "haml-rails"

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

group :development, :test do
  gem 'sqlite3'
end

group :production do
  gem 'pg'
  gem 'thin'
end

