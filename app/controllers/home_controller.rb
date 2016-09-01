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
    @missions = Mission.all.reverse
    @performed_missions = PerformedMission.all.reverse
    @user.profile_img = params[:profile_img]
    
  end
  
  def profile_img_upload
      @user = User.find(params[:id])  
      @user.profile_img = params[:profile_img]
      @user.save
      redirect_to '/home/timeline/<%= @user.id %>'
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
