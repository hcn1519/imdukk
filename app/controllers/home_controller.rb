class HomeController < ApplicationController
  # before_action :authenticate_user!
  # MainPageCount = 9
  
  def main
    @missions = Mission.all.reverse
  
    # 미션 제작자
    @mission_creator = Array.new
    
    @missions.each do |m|
      @mission_creator.push(m.user_id)
    end
    
    # 좋아요 용
    if user_signed_in?
      @userlike = MissionLike.where(:user_id => current_user.id, :mission_like => 1)
    end
    
  end
  
  def timeline
    @user = User.find(params[:id])
    
    # 회원체크
    unless current_user.nil?
      # 유저가 타임라인 주인이라면
      if @user.id == current_user.id
      # 타임라인 들어온거라면 수정 삭제 보여주기
      # 타임라인 들어온거라면 프로필 사진 변경 가능하게 하기
      else
      # 다른 사람 수정 삭제 보여주지 말기
      end
    end
    @userCreatedMission = Mission.where(user_id: @user.id)
    @userPerformedMission = PerformedMission.where(user_id: @user.id)
    @missions = Mission.where(user_id: @user.id).reverse
    @performed_missions = PerformedMission.where(user_id: @user.id).reverse
    @user.profile_img = params[:profile_img]
    @missions_like = @missionLike.to_a.count
    #덕포인트 
    @duckpoint = @missions.to_a.count + @performed_missions.to_a.count
    @timeline_duckpoint = @duckpoint*5
    # @timeline_duckpoint = (5..100000).to_a.count()
      if @timeline_duckpoint >= 5 and @timeline_duckpoint < 50
          path = view_context.image_path('images/duck1.png')
      elsif @timeline_duckpoint >= 50 and @timeline_duckpoint < 100
          path = view_context.image_path('images/duck2.png')
      elsif @timeline_duckpoint >= 100 and @timeline_duckpoint < 500
          path = view_context.image_path('images/duck3.png')
      elsif @timeline_duckpoint >= 500 and @timeline_duckpoint < 1000
          path = view_context.image_path('images/duck4.png')
      else @timeline_duckpoint >= 5000
          path = view_context.image_path('images/duck5.png')
      end
  end
 
  def profile_img_upload
      @user = User.find(params[:id])  
      @user.profile_img = params[:profile_img]
      @user.save
      redirect_to controller: 'home', action: "timeline", id: current_user.id
  end

  def timeline_temp
    # @user = User.find(params[:id])   
    
    @missions = Mission.all.reverse
    @performed_missions = PerformedMission.all.reverse
    current_user.profile_img = params[:user_profile_img]
    
  end
  
  def missionLike
    @likedMission = Mission.find(params[:id])
    
    @missionLike = MissionLike.where(:mission_id => @likedMission.id, :user_id => current_user.id)
    
    # 처음 좋아요 +
    if @missionLike.first.nil?
      @missionLike = MissionLike.new
      @missionLike.user_id = current_user.id
      @missionLike.mission_id = @likedMission.id
      @missionLike.mission_like = 1
      @missionLike.save
      @likedMission.mission_like_count = @likedMission.mission_like_count + 1

    # 나중
    else
      # 좋아요 +
      if @missionLike.first.mission_like == 0 
        @missionLike.first.mission_like = 1
        @likedMission.mission_like_count = @likedMission.mission_like_count + 1
      # 좋아요 -
      else
        @missionLike.first.mission_like = 0
        @likedMission.mission_like_count = @likedMission.mission_like_count - 1
      end
      @missionLike.first.save
    end
    
    @likedMission.save
    
  end
end
