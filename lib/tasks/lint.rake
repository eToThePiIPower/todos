namespace :lint do
  desc 'Run javascript assets against eslint'
  task eslint: :environment do
    eslint = Rails.root.join('node_modules', '.bin', 'eslint')
    raise 'ESLint is not installed. Try running npm install first.' unless File.exist?(eslint)

    puts ''
    sh eslint.to_s + ' --max-warnings 0 ' + Rails.root.to_s do |ok|
      if ok
        puts "\e[32mESLint completed: no offences\e[0m"
      else
        abort "\e[31mESLint found offences\e[0m"
      end
    end
  end

  desc 'Run ruby files against rubocop'
  task rubocop: :environment do
    puts ''
    sh 'bundle exec rubocop --rails' do |ok|
      if ok
        puts "\e[32mRuboCop completed: no offences\e[0m"
      else
        abort "\e[31mRuboCop found offences\e[0m"
      end
    end
  end

  desc 'Run slim-lint against slim views'
  task slim: :environment do
    puts ''
    sh 'bundle exec slim-lint app/views' do |ok|
      if ok
        puts "\e[32mSlim-Lint completed: no offences\e[0m"
      else
        abort "\e[31mSlim-Lint found offenses\e[0m"
      end
    end
  end

  desc 'Run all linters'
  task all: [:rubocop, :slim, :eslint]
end

task :lint do
  Rake::Task['lint:all'].invoke
end
