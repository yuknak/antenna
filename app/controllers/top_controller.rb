class TopController < ApplicationController
  
  # To enable/disable caching in dev mode (default: disabled),
  # run rails dev:cache to toggle caching.
  # Also see in config/environments/*.rb

  private def cached_all_articles
    Rails.cache.fetch("/model/article/all", expired_in: 10.minutes) do
      Article.order('post_time desc').limit(150)
    end
  end
  private def cached_category_id_articles
    Rails.cache.fetch("/model/article/category/#{@category_id}", expired_in: 10.minutes) do
      Article.where(category_id: @category_id).order('post_time desc').limit(150)
    end
  end
  private def cached_site_id_articles(site_id)
    Rails.cache.fetch("/model/article/site/#{site_id}", expired_in: 10.minutes) do
      Article.where(site_id: site_id).order('post_time desc').limit(5)
    end
  end
  private def cached_all_sites
    Rails.cache.fetch("/model/site/all", expired_in: 10.minutes) do
      Site.order('weight desc').limit(100)
    end
  end
  private def cached_catgory_id_sites
    Rails.cache.fetch("/model/site/category/#{@category_id}", expired_in: 10.minutes) do
      Site.where(category_id: @category_id).order('weight desc').limit(100)
    end
  end

  def index
    
    @category_id = params[:id]

    if @category_id.blank? then
      @articles = cached_all_articles
      @sites = cached_all_sites
    else
      @articles = cached_category_id_articles
      @sites = cached_catgory_id_sites
    end

    @site_articles = []
    @sites.each { |site|
      articles = cached_site_id_articles(site.id)
      @site_articles.push(articles)
    }

  end
end
