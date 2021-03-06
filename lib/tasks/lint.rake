namespace :lint do
  desc 'Run javascript assets against eslint'
  task eslint: :environment do
    puts ''
    eslint = Rails.root.join('node_modules', 'eslint', 'bin', 'eslint.js')
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
    puts ''
    sh "bundle exec rubocop --rails #{Rails.root}" do |ok|
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
    sh "bundle exec slim-lint #{Rails.root}/app/views" do |ok|
      if ok
        puts "\e[32mSlim-Lint completed: no offences\e[0m"
      else
        abort "\e[31mSlim-Lint found offenses\e[0m"
      end
    end
  end

  desc 'Run remark against markdown files'
  task remark: :environment do
    puts ''
    remark = Rails.root.join('node_modules', 'remark-cli', 'cli.js')
    raise 'remark is not installed. Try running npm install first.' unless File.exist?(remark)

    sh remark.to_s + ' -u remark-lint --frail ' + Rails.root.to_s do |ok|
      if ok
        puts "\e[32mRemark completed: no offences\e[0m"
      else
        abort "\e[31mRemark found offences\e[0m"
      end
    end
  end

  desc 'Run scss-lint against stylesheets'
  task scss: :environment do
    puts ''
    sh "bundle exec scss-lint #{Rails.root}/app/assets/stylesheets" do |ok|
      if ok
        puts "\e[32mscss-lint completed: no offences\e[0m"
      else
        abort "\e[31mscss-lint found offences\e[0m"
      end
    end
  end

  desc 'Run all linters'
  task all: [:rubocop, :slim, :scss, :eslint, :remark]
end

task :lint do
  Rake::Task['lint:all'].invoke
end
