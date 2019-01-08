# encoding: utf-8

# Rake command: rake moudamepo:fetch > db/seeds.rb
# Generate db/seeds.rb
# Fetching sample data from moudamepo.com
# This file simply produces a ruby source file to STDOUT.

require 'open-uri'
require 'nokogiri'
require 'kconv'

namespace :moudamepo do

  BASEURL =  'http://moudamepo.com'

  top_level = self
  using Module.new {
  refine(top_level.singleton_class) do

  def categories
    result = ''
    fetch_as_doc().xpath('//ul/li/a').each do |node|
      title = node.inner_text
      category_id = node.attribute('href').text
      category_id.sub!(/\//,"")
      icon_url = "http://sub.moudamepo.com/img/cate_" + category_id + ".png"
      if (/^\d+$/ =~ category_id)
        result += "Category.create(:name => '" + title + 
          "',\n  :icon_url => '" + icon_url + "') # moudamepo's id = " + category_id + "\n"
      end
    end        
    result
  end
  
  # We have to map moudamepo id to auto incremental id
  def category_id_binds
    cnt = 1;
    result = "# Mapping for moudamepo.com id to autoincrement id.\n"
    result += "category_id_binds = {\n"
    fetch_as_doc().xpath('//ul/li/a').each do |node|
      category_id = node.attribute('href').text
      category_id.sub!(/\//,"")
      if (/^\d+$/ =~ category_id)
        result += "  " + category_id + " => " + cnt.to_s + ",\n"
        cnt += 1;
      end
    end
    result += "}\n"
    result
  end

  # We have to map moudamepo name to auto incremental id
  def category_name_binds
    cnt = 1;
    result = "# Mapping for moudamepo.com name to autoincrement id.\n"
    result += "category_name_binds = {\n"
    fetch_as_doc().xpath('//ul/li/a').each do |node|
      name = node.inner_text
      category_id = node.attribute('href').text
      category_id.sub!(/\//,"")
      if (/^\d+$/ =~ category_id)
        result += "  '" + name + "' => " + cnt.to_s + ",\n"
        cnt += 1;
      end
    end
    result += "}\n"
    result
  end
    
  # Search toppage 1-8 for the information
  def sites(page) # (page = 1 - 8)
    result = ''
    cnt = 1;
    count_date = Time.new.yesterday.strftime("%Y%m%d") # It is in localtime.
    fetch_as_doc(page).xpath("//table[@class='bloginfo']").each do |node|
      name = node.xpath(".//a[@class='blogname']").inner_text
      url = node.xpath(".//a[@class='blogname']").attribute('href').text
      url.sub!(/^.+?http/,"http")
      category_name = node.xpath(".//div[@class='rank_name']/img").attribute('alt').text
      icon_url = node.xpath(".//div[@class='rank']/img").attribute('src').text
      thumbnail_url = node.xpath(".//img[contains(@src, 'screenshot')]").attribute('src').text
      in_count = node.xpath(".//div[@class='rank_inout']").inner_text
      in_count.sub!(/ in.+?$/,"")
      out_count = node.xpath(".//div[@class='rank_inout']").inner_text
      out_count.sub!(/ out$/,"")
      out_count.sub!(/^\d+? in \/ /,"")
      feed_url = fetch_feed_url(url)
      if feed_url.empty? then
        STDERR.print "SKIPPED: feed_url not found: " + name + ": " + url + "\n"
        next
      else
        STDERR.print "SUCCESS: " + name + ": " + url + "\n"
      end
      # Time.new.to_s contains timezone info
      result += "s = Site.create(:name => %q#" + name + "#, \n  :url => '" + url +
        "', \n  :category_id => category_name_binds['" + category_name +
        "'], \n  :feed_url => '"+feed_url+"',\n  :thumbnail_url => '" + thumbnail_url +
#       "',\n  :icon_url => '" + icon_url + "', \n  :last_post_time => '" + Time.new.to_s + "')\n"
        "',\n  :icon_url => '" + icon_url + "')\n"
      # Insert to yesterday(localtime)
      result += "DailyInCount.create(:count_date => " + count_date +
        ", :site_id => s.id, :count => " + in_count + ")\n"
      result += "DailyOutCount.create(:count_date => " + count_date +
        ", :site_id => s.id, :count => " + out_count + ")\n"
      cnt += 1
      #break if (cnt > 2)
    end        
    result
  end

  private def fetch_as_html(category_id = 1)
    url = BASEURL
    if (category_id.to_i == 1) then url += '/index.html'
      else url += '/index_' + category_id.to_s + '.html' end
    charset = nil
    html = open(url) do |f|
      charset = f.charset; f.read
    end
  end
  
  private def fetch_as_doc(category_id = 1)
    url = BASEURL
    if (category_id.to_i == 1) then url += '/index.html'
      else url += '/index_' + category_id.to_s + '.html' end
    charset = nil
    html = open(url) do |f|
      charset = f.charset; f.read
    end
    Nokogiri::HTML.parse(html, nil, charset)
  end

  # Extracting rss feed link url in toppage
  private def fetch_feed_url(url)
    charset = nil
    html = open(url, "r:binary") do |f|
      charset = f.charset; f.read
    end
    # Because page may be encoded in EUC-JP
    doc = Nokogiri::HTML.parse(html.toutf8, nil, "UTF-8")
    feed_url = ''
    # Mainly it should be in header/link tags
    doc.xpath("//link").each { |node|
      chkurl = chkrel = chktype = nil
      chkurl = node.attribute('href').text if node.attribute('href')
      chkrel = node.attribute('rel').text if node.attribute('rel')
      chktype = node.attribute('type').text if node.attribute('type')
      if (chkurl) then
        if ((chktype && (/rss/i =~ chktype || /atom/i =~ chktype) && /(rdf|xml|rss|feed)/ =~ chkurl) ||
            (chkrel && /alternate/i =~ chkrel && /(rdf|xml|rss|feed)/ =~ chkurl)) then
            feed_url = chkurl
            if (/^http/ !~ feed_url) then
              feed_url = url.chomp("/") + feed_url
            end
            break
          end
      end
    }
    # If not, sometimes it may be simply in normal a tags with a special form
    if (feed_url.empty?) then
      doc.xpath("//a").each { |node|
        chkurl = nil
        chkurl = node.attribute('href').text if node.attribute('href')
        if (chkurl) then
          if ((/[\/\?\.](rdf|xml|rss|feed)\/*$/ =~ chkurl)||
                (/[\/\?\.]feed=[a-zA-Z0-9]*$/ =~ chkurl)) then
              feed_url = chkurl
              if (/^http/ !~ feed_url) then
                feed_url = url.chomp("/") + feed_url
              end
              break
            end
        end
      }
    end
    feed_url
  end

  end # refine(top_level.singleton_class) do
  }   # using Module.new {

  desc "Making for seeds.rb fetching sample data from moudamepo.com."

  task fetch: :environment do |task, args|

    puts  "# Generated by lib/tasks/moudamepo.rake"
    puts  "#  rake moudamepo:fetch > db/seeds.rb"
    print "#  generated at ", Time.new, "\n\n"
  
    print categories
    print category_name_binds
    print category_id_binds
    endcnt = 8
    (1..endcnt).each { |n|
      STDERR.print "PROCESS: PAGE: " + n.to_s + "/" + endcnt.to_s + " ----------------\n"
      print        "# Site PAGE: " + n.to_s + "/" + endcnt.to_s + " ----------------\n"
      print sites(n)
    }

  end

end