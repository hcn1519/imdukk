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
  end
  
  def timeline
    @user = User.find(params[:id])
    @mission = Mission.find(params[:id])
    
    # 회원체크
    unless current_user.nil?
      # 유저가 타임라인 주인이라면
      if @user.id == current_user.id
      # 다른 사람 타임라인 들어온거라면 수정 삭제 보여주기
      else
      # 수정 삭제 보여주지 말기
      end
    end
    @userCreatedMission = Mission.wherse(user_id: @user.id)
    @userPerformedMission = PerformedMission.where(user_id: @user.id)
  end

  def timeline_temp
    @missions = Mission.all.reverse
    @performed_missions = PerformedMission.all.reverse

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
