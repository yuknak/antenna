class OldController < ApplicationController
  def index
    
    site_id = params[:s]
    redirect_to :root if site_id.blank?
    
    @site = Site.find(site_id)
    redirect_to :root if @site.blank?
    
    @articles = Article.where(site_id: @site.id, post_time: 2.weeks.ago..Time.now).order('post_time desc')
    redirect_to :root if @articles.nil?
  
    tmpl_num = CONFIG['repo_id'] / 10
    render "index" + tmpl_num.to_s

  end
end