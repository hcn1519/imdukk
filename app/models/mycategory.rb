class Mycategory < ActiveRecord::Base
  has_many :user_categories
  has_many :users, :through => :user_category, :source => :user
end
