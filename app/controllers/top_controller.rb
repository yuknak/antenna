class TopController < ApplicationController
  def index
    @articles = Article.order('post_time desc').limit(150)
  end
end
