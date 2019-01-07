class Site < ApplicationRecord
  belongs_to :category
  has_many :articles
  has_many :daily_in_counts
  has_many :daily_out_counts
  #has_many :in_histories
  #has_many :out_histories
end