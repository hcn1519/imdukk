class Mission < ActiveRecord::Base    
    belongs_to :user
    belongs_to : category
    has_many :performed_missions
    has_many :mission_likes
    has_many :mission_comments
    has_many :mission_likes, :through => :mission_likes, :source => :user
    has_many :mission_comments, :through => :mission_comments, :source => :user
end
