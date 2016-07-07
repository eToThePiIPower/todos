ruby ENV['TRAVIS_RUBY_VERSION'] || '2.3.1'
source 'https://rubygems.org'

gem 'rails', '4.2.6'
gem 'pg', '~> 0.15'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'

gem 'jquery-rails'
gem 'turbolinks'
gem 'jquery-turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc

gem 'bootstrap-sass', '~> 3.3.6'
gem 'bootswatch-rails'
gem 'data-confirm-modal',
    git: 'git://github.com/eToThePiIPower/data-confirm-modal.git',
    branch: 'feat/add-custom-data-modal-class-attribute-support'
gem 'font-awesome-rails'
gem 'slim', '~> 3.0.7'

gem 'devise'

gem 'codecov', require: false, group: :test

gem 'rails_12factor', group: :production

group :development, :test do
  gem 'byebug'
  gem 'capybara'
  gem 'dotenv-rails'
  gem 'factory_girl_rails', '~> 4.0'
  gem 'launchy'
  gem 'poltergeist'
  gem 'rspec-rails', '~> 3.4.2'
  gem 'shoulda-matchers', '~> 3.1'
  gem 'slim_lint'
  gem 'scss_lint', '~> 0.48', require: false
end

group :development do
  gem 'web-console', '~> 2.0'
  gem 'spring'
  gem 'rubocop', '~> 0.40.0'
  gem 'pry-rails'
  gem 'mutant-rspec'
end
