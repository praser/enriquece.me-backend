# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'active_model_serializers'
gem 'bcrypt', '~> 3.1.7'
gem 'jwt'
gem 'mongoid', '~> 6.2.0'
gem 'newrelic_rpm'
gem 'puma', '~> 3.0'
gem 'rack-attack'
gem 'rack-cors'
gem 'rails', '~> 5.1.1'
gem 'recurrence', require: 'recurrence/namespace'
gem 'sidekiq'
gem 'simple_command'
gem 'versionist'

group :development, :test do
  gem 'awesome_print'
  gem 'byebug', platform: :mri
  gem 'codacy-coverage', require: false
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'json-schema'
  gem 'mongoid-rspec', github: 'mongoid-rspec/mongoid-rspec'
  gem 'rails-controller-testing'
  gem 'rspec-rails', '~> 3.5'
  gem 'simplecov', require: false
end

group :development do
  gem 'listen', '~> 3.1.5'
  gem 'rubocop', '~> 0.49.1', require: false
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
