namespace :mutant do
  desc 'Run mutantion tests to test your test coverage on models'
  task models: :environment do
    puts ''
    models = 'TodoItem TodoList User'

    sh "RAILS_ENV=test bundle exec mutant -r ./config/environment --use rspec #{models}"
  end

  desc 'Run mutantion tests to test your test coverage on controllers'
  task controllers: :environment do
    puts ''
    controllers = 'TodoItemsController TodoListsController ApplicationController StaticPagesController'

    sh "RAILS_ENV=test bundle exec mutant -r ./config/environment --use rspec #{controllers}"
  end

  desc 'Run mutantion tests to test your test coverage'
  task all: :environment do
    puts ''
    models = 'TodoItem TodoList User'
    controllers = 'TodoItemsController TodoListsController ApplicationController StaticPagesController'

    sh "RAILS_ENV=test bundle exec mutant -r ./config/environment --use rspec #{models} #{controllers}"
  end
end
