class AboutController < ApplicationController
def index

  @categories = Category.all
  
  design = CONFIG['design']
  render "index" + design.to_s

end
end
