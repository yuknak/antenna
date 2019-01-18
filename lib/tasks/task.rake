# encoding: utf-8

# bundle exec rails task:site
# bundle exec rails task:article
# bundle exec rails task:daily

namespace :task do

  task site: :environment do |task, args|

    next if CONFIG['repo_id'] != 1
    Rails.logger = Logger.new("log/task.log", 5, 5 * 1024 * 1024)
    Rails.logger.level = Logger::INFO
    TaskController.new.site

  end

  task article: :environment do |task, args|

    next if CONFIG['repo_id'] != 1
    Rails.logger = Logger.new("log/task.log", 5, 5 * 1024 * 1024)
    Rails.logger.level = Logger::INFO
    TaskController.new.article

  end

  task daily: :environment do |task, args|

    next if CONFIG['repo_id'] != 1
    Rails.logger = Logger.new("log/task.log", 5, 5 * 1024 * 1024)
    Rails.logger.level = Logger::INFO
    TaskController.new.daily

  end

end