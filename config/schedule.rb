# To run:
# bundle exec whenever -i

require File.expand_path(File.dirname(__FILE__) + "/environment")
rails_env = ENV['RAILS_ENV'] || :development
set :environment, rails_env
set :output, "#{Rails.root}/log/cron.log"

every 10.minutes do
  rake "rss:fetch"
end
