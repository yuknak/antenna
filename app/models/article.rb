class Article < ApplicationRecord
  belongs_to :site
  #has_many :out_histories
  has_many :article_out_counts
end