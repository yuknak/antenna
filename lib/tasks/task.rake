# encoding: utf-8

# Rake command: rake rss:fetch

require 'open-uri'
require 'kconv'
require "feedjira"

namespace :task do

  task site: :environment do |task, args|

    TaskController.new.site

  end

  task article: :environment do |task, args|

    TaskController.new.article

  end

end