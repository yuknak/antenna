class Article < ApplicationRecord
  belongs_to :site
  belongs_to :category
  #has_many :out_histories
  has_many :article_out_counts
end