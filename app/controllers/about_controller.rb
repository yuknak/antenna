class AboutController < ApplicationController
def index
  
  tmpl_num = CONFIG['repo_id'] / 10
  render "index" + tmpl_num.to_s

end
end
