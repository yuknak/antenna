class TaskController < ApplicationController

  BASEURL =  'http://moudamepo.com'

  #############################################################################

  def article

    unless Category.table_exists?
      puts "Run \"rails db:create\" and \"rails db:migrate\"."
      return
    end

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
  end # article

  #############################################################################

  private def categories
    fetch_as_doc().xpath('//ul/li/a').each do |node|
      title = node.inner_text
      category_id = node.attribute('href').text
      category_id.sub!(/\//,"")
      icon_url = "http://sub.moudamepo.com/img/cate_" + category_id + ".png"
      if (/^\d+$/ =~ category_id)
        category = Category.find_or_initialize_by(
          ex_id: category_id
        )
        category.name = title
        category.icon_url = icon_url
        category.save!
      end
    end        
  end
      
  # Search toppage 1-8 for the information
  private def sites(page) # (page = 1 - 8)
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
      ex_id = node.xpath(".//a[contains(@href, 'old.cgi')]").attribute('href').text
      ex_id.sub!(/old.cgi\?/,"")
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
      match_in_url  = URI.parse(url).host
      if match_in_url == "blog.livedoor.jp" then # Special handling
        match_in_url += ("/" + URI.parse(url).path.split("/")[1])
      end

      # Update site
      site = Site.find_or_initialize_by(
        ex_id: ex_id
      )
      site.name = name
      site.url = url
      site.category_id = Category.where(name: category_name).first.id
      site.feed_url = feed_url
      site.thumbnail_url = thumbnail_url
      site.icon_url = icon_url
      site.match_in_url = match_in_url
      site.save!

      # Update yesterday data(localtime)
      daily_weight = DailyWeight.find_or_initialize_by(
        weight_date: count_date,
        site_id: site.id
      )
      daily_weight.weight = out_count
      daily_weight.save!
  
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

  def site

    unless Category.table_exists?
      puts "Run \"rails db:create\" and \"rails db:migrate\"."
      return
    end
    
    categories
    
    endcnt = 8
    (1..endcnt).each { |n|
      STDERR.print "PROCESS: PAGE: " + n.to_s + "/" + endcnt.to_s + " ----------------\n"
      print        "# Site PAGE: " + n.to_s + "/" + endcnt.to_s + " ----------------\n"
      print sites(n)
    }

  end

  #############################################################################

end