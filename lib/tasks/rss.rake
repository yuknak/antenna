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
      #feed.title,feed.url,feed.last_modified are available
      feed = Feedjira::Feed.fetch_and_parse(site.feed_url)
      # TODO: sometimes feed.last_modified seems to be zero(1970/1/1...)
      if (site.last_post_time.blank? ||
        site.last_post_time < feed.last_modified) then
        feed.entries.each { |entry|
          begin
            STDERR.print entry.title + "\n"
            STDERR.print entry.url + "\n"
            STDERR.print entry.published.to_s + "\n"
            # Unique key is made from article's url
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
        # store last time
        site.update(:last_post_time => feed.last_modified)
      end # if last_modified
      rescue => e
        print STDERR.print(e.message + "\n")
        next
      end
    } # Site.all.each
  end # fetch

  end # refine(top_level.singleton_class) do
  }   # using Module.new {

  desc "Fetch rss feeds."

  task fetch: :environment do |task, args|

    fetch;

  end

end