source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.1"

gem "dotenv-rails", groups: %i[development test]
gem "rails", "~> 7.0.3"
gem "jwt"
gem "sprockets-rails"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "bcrypt", "~> 3.1.7"
gem "bootsnap", require: false
gem "rack-cors"
gem "simplecov", require: false, group: :test

group :development, :test do
  gem "pry-rails"
  gem "rspec-rails"
  gem "guard"
  gem "guard-rspec"
  gem "factory_bot_rails"
  gem "faker"
  gem "byebug", platforms: %i[mri mingw x64_mingw]
end

group :development do
  gem "annotate"
  gem "web-console", ">= 3.3.0"
  gem "listen", "~> 3.2"
  gem "prettier"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end
