source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.2'

gem 'active_model_serializers', '~> 0.10.12'
gem 'api-pagination', '~> 4.8', '>= 4.8.2'
gem 'bcrypt', '~> 3.1', '>= 3.1.16'
gem 'brakeman', '~> 5.1', '>= 5.1.1'
gem 'has_scope', '~> 0.7.2'
gem 'jwt', '~> 2.3'
gem 'paper_trail', '~> 12.1'
gem 'parallel', '~> 1.20', '>= 1.20.1'
gem 'paranoia', '~> 2.4', '>= 2.4.3'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rails', '~> 6.1', '>= 6.1.4'
gem 'ros-apartment', '~> 2.8', '>= 2.8.1', require: 'apartment'
gem 'scenic', '~> 1.5', '>= 1.5.4'
gem 'will_paginate', '~> 3.3'

group :development, :test do
  gem 'dotenv-rails', '~> 2.7', '>= 2.7.6'
  gem 'factory_bot_rails', '~> 6.1'
  gem 'parallel_tests', '~> 3.4'
  gem 'pry-byebug', '~> 3.9'
end

group :test do
  gem 'database_cleaner', '~> 1.8', '>= 1.8.5'
  gem 'faker', '~> 2.15', '>= 2.15.1'
  gem 'rspec-rails', '~> 5.0'
  gem 'shoulda-matchers', '~> 4.5'
end

group :development do
  gem 'rubocop', '~> 1.22', '>= 1.22.1'
  gem 'rubocop-faker', '~> 1.1'
  gem 'rubocop-rails', '~> 2.12', '>= 2.12.4'
end

gem 'tzinfo-data', '~> 1.2020', '>= 1.2020.6', platforms: %i[mingw mswin x64_mingw jruby]
