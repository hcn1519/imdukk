class User < ActiveRecord::Base
  has_many :user_categories
  has_many :mycategories, :through => :user_category, :source => :mycategory
  
  has_many :missions
  has_many :performed_missions
  
  # has_many :performed_mission_likes
  # has_many :performed_mission_comments
  # has_many :performed_likes, through :performed_mission_likes, source: :performed_mission
  # has_many :performed_comments through :performed_mission_comments, source: :performed_mission
  
  # has_many :mission_likes, through :mission_likes, source: :mission
  # has_many :mission_comments, through mission_comments, source: :mission


  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  has_many :identities

  def self.find_for_oauth(auth, signed_in_resource = nil)

    # user와 identity가 nil이 아니라면 받는다
    identity = Identity.find_for_oauth(auth)
    user = signed_in_resource ? signed_in_resource : identity.user

    # user가 nil이라면 새로 만든다.
    if user.nil?

      # 이미 있는 이메일인지 확인한다.
      email = auth.info.email
      user = User.where(:email => email).first  
      
      unless self.where(email: auth.info.email).exists?
        # 없다면 새로운 데이터를 생성한다.
        if user.nil?
          # 트위터는 email을 제공하지 않음
          if auth.provider == "twitter"
            user = User.new(
              profile_img: auth.info.image,
              password: Devise.friendly_token[0,20]
            )    
          
          else  
            user = User.new(
              email: auth.info.email,
              profile_img: auth.info.image,
              password: Devise.friendly_token[0,20]
            )            
          end 
          user.save!
        end

      end

    end

    if identity.user != user
      identity.user = user
      identity.save!
    end
    user

  end

  # email이 없어도 가입이 되도록 설정
  def email_required?
    false
  end

  def email_changed?
    false
  end
end