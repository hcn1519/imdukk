class Mission < ActiveRecord::Base    
    belongs_to :user
    belongs_to :category
    has_many :performed_missions
    has_many :mission_likes
    has_many :mission_comments
    has_many :mission_likes, :through => :mission_likes, :source => :user
    has_many :mission_comments, :through => :mission_comments, :source => :user
    validates :content, presence: { message: "내용을 입력하세요." }
    # validates :content, presence: { message: "사진 또는 영상을 첨부하세요." }
    mount_uploader :multimedia, MissionMultimediaUploader
    
    acts_as_taggable 
    acts_as_taggable_on :creator_hashtags
end