class OutController < ApplicationController
  def index
    
    site_id = params[:s]
    article_id = params[:a]
    url = params[:u]
    
    last_time = Time.new
    count_date = last_time.localtime.strftime("%Y%m%d")
    
    if (site_id.present?) then
        daily_out_count = DailyOutCount.find_or_initialize_by(
        repo_id: CONFIG['repo_id'],
        site_id: site_id.to_i,
        count_date: count_date.to_i,
      )
      daily_out_count.count += 1
      daily_out_count.save! 
    end
    
    if (article_id.present?) then
      article_out_counts = ArticleOutCount.find_or_initialize_by(
        repo_id: CONFIG['repo_id'],
        article_id: article_id.to_i,
      )
      article_out_counts.last_time = last_time
      article_out_counts.count += 1
      article_out_counts.save!
    end

    redirect_to url if url.present?
  end
end