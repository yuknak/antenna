# encoding: utf-8

# Rake command: rake rss:fetch

require 'open-uri'
require 'kconv'
require "feedjira"

namespace :rss do

  top_level = self
  using Module.new {
  refine(top_level.singleton_class) do

  def fetch
    Site.all.each { |site|
      begin
      feed = Feedjira::Feed.fetch_and_parse(site.feed_url)
      #feed.title,feed.url,feed.last_modified
      feed.entries.each { |entry|
        begin
          STDERR.print entry.title + "\n"
          STDERR.print entry.url + "\n"
          STDERR.print entry.published.to_s + "\n"
          md5hash = Digest::MD5.hexdigest(entry.url)
          article = Article.find_or_initialize_by(
            site_id: site.id,
            post_time: entry.published,
            chkd: md5hash
          )
          article.url = entry.url
          article.name = entry.title
          article.pull_time = Time.new
          article.save! 
        rescue => e
          print STDERR.print(e.message + "\n")
          next
        end
      }
      rescue => e
        print STDERR.print(e.message + "\n")
        next
      end
    }
  end

  end # refine(top_level.singleton_class) do
  }   # using Module.new {

  desc "Fetch rss feeds."

  task fetch: :environment do |task, args|

    fetch;

  end

end