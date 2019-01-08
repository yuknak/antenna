class TopController < ApplicationController
  def index
    category_id = params[:id]
    if category_id.blank? then
      @articles = Article.order('post_time desc').limit(150)
    else
      @articles = Article.where(category_id: category_id).order('post_time desc').limit(150)
    end
  end
end
