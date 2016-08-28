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
    
    # 회원체크
    unless current_user.nil?
      # 유저가 타임라인 주인이라면
      if @user.id == current_user.id
      # 다른 사람 타임라인 들어온거라면
      else
      end
    end
    @userCreatedMission = Mission.where(user_id: @user.id)
    @userPerformedMission = PerformedMission.where(user_id: @user.id)
  end

  def timeline_temp
    @missions = Mission.all
  end
  
end
