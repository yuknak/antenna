class Category < ApplicationRecord
  has_many :sites
  has_many :articles
end