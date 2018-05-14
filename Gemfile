# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

gem 'bson', '~> 4.3'
gem 'mongo', '~> 2.5'

# https://github.com/bkeepers/dotenv
gem 'dotenv', '~> 2.2'

group :development do
  gem 'awesome_print', require: 'ap'
  gem 'pry'
  gem 'rubocop', require: false
  gem 'rubocop-rspec'
  gem 'builder'
  gem 'squid', '~> 1.2'
  gem 'prawn'
end

group :test do
  gem 'coderay', '~> 1.1'
  gem 'rspec', '~> 3.7'

  gem 'simplecov', '~> 0.15', require: false
end