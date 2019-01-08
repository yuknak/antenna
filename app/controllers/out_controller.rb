class OutController < ApplicationController
  def index
    site_id = params[:s];
    url = params[:u]
    count_date = Time.new.localtime.strftime("%Y%m%d")
    daily_out_count = DailyOutCount.find_or_initialize_by(
      site_id: site_id.to_i,
      count_date: count_date.to_i,
    )
    daily_out_count.count += 1;
    daily_out_count.save! 
    redirect_to url
  end
end