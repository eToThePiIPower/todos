namespace :lint do
  desc 'Run javascript assets against eslint'
  task eslint: :environment do
    eslint = Rails.root.join('node_modules', '.bin', 'eslint')
    puts eslint
    raise 'ESLint is not installed. Try running npm install first.' unless File.exist?(eslint)

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
    sh 'rubocop'
  end

  desc 'Run all linters'
  task all: [:rubocop, :eslint]
end
