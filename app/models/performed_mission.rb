class PerformedMission < ActiveRecord::Base
    belongs_to :mission
    belongs_to :user
    has_many :performed_mission_like
    has_many :performed_mission_comments
    has_many :performed_mission_likes, :through => :performed_mission_like, :source => :user
    has_many :performed_mission_comments, :through => :performed_mission_comment, :source => :user
    belongs_to :category
    mount_uploader :multimedia, PerformedMissionMultimediaUploader
end
