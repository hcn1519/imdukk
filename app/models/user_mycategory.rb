class UserMycategory < ActiveRecord::Base
  belongs_to :user
  belongs_to :mycategory
end
