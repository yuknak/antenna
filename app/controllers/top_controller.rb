class TopController < ApplicationController
  def index
    
    @category_id = params[:id]

    if @category_id.blank? then
      @articles = Article.order('post_time desc').limit(150)
      @sites = Site.order('week_out_count desc').limit(20)
    else
      @articles = Article.where(category_id: @category_id).order('post_time desc').limit(150)
      @sites = Site.where(category_id: @category_id).order('week_out_count desc').limit(20)
    end

    @site_articles = []
    @sites.each { |site|
      articles = Article.where(site_id: site.id).order('post_time desc').limit(5)
      @site_articles.push(articles)
    }

  end
end
