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
      # TODO:
      # No valid parser for XML. error.
      # TODO:
      # http://animalch.net/feed
      # Cannot parse correctly: "<pubDate>Tue, 08 Jan 2019 10:34:38 0</pubDate>"
      # Maybe this is a glich of the site.
      # This is a quick hack only for JP, forcibly parsing as JST(+0900) zone.
      xml = Faraday.get(site.feed_url).body
      xml.gsub!(/ 0<\/pubDate>/," +0900</pubDate>")
      #feed.title,feed.url,feed.last_modified are available
      feed = Feedjira::Feed.parse xml
      # TODO: feed.last_modified seems to be zero(1970/1/1...)
      # http://tuccom.com/feed
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
            article.category_id = site.category_id
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

  def test
    url = ""
    xml = Faraday.get(url).body
    feed = Feedjira::Feed.parse xml
    feed.entries.each { |entry|
        STDERR.print entry.title + "\n"
        STDERR.print entry.url + "\n"
        STDERR.print entry.published.to_s + "\n"
    }
  end

  end # refine(top_level.singleton_class) do
  }   # using Module.new {

  desc "Fetch rss feeds."

  task fetch: :environment do |task, args|

    fetch
    #test

  end

end