class AboutController < ApplicationController
def index
  
  design = CONFIG['design']
  render "index" + design.to_s

end
end
