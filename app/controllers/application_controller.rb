class ApplicationController < ActionController::Base
  
  after_action :process_daily_in_counts
  before_action :basic
  
  private def basic
      return unless CONFIG['admin']['entire_lock']
      authenticate_or_request_with_http_basic do |user, pass|
        user == CONFIG['admin']['user'] && pass == CONFIG['admin']['pass']
      end
    end

  private def process_daily_in_counts
    return if response.status != 200
    return if request.referer.blank?
    return if request.referer.index('http') != 0
    # Exclude from my domain
    return if URI.parse(request.referer).host == request.domain
    #logger.debug(request.domain)
    #logger.debug(request.referer)
    site_id = 0;
    Site.all.order("LENGTH(match_in_url) DESC").each { |site|
      next if site.match_in_url.blank?
      #logger.debug(site.match_in_url)
      if request.referer.include?(site.match_in_url) then
        site_id = site.id
        break
      end
    }
    return if site_id == 0
    count_date = Time.new.localtime.strftime("%Y%m%d")
    daily_in_count = DailyInCount.find_or_initialize_by(
      site_id: site_id,
      repo_id: CONFIG['repo_id'],
      count_date: count_date.to_i,
    )
    daily_in_count.count += 1;
    daily_in_count.save! 
  end

end