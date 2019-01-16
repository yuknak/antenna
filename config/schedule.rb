# To run:
# bundle exec whenever -i

require File.expand_path(File.dirname(__FILE__) + "/environment")
rails_env = ENV['RAILS_ENV'] || :development
set :environment, rails_env

#set :output, "#{Rails.root}/log/cron.log"

# task log is log/task.log [->task.log.1-5]
# see lib/tasks/task.rake

every 10.minutes do
  rake "task:article"
end

every 1.day, at: '3:35 am' do
  rake "task:site"
end

every 1.day, at: '4:35 am' do
  rake "task:daily"
end