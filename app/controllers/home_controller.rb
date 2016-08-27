class HomeController < ApplicationController
  def main
    @missions = Mission.all
    # @one_mission = Mission.find(params[:id])
    
    @mission_creator = Array.new
    
    @missions.each do |m|
      @mission_creator.push(m.user_id)
    end
    
  end
  
  def timeline
    @user = current_user
    
    @userCreatedMission = Mission.where(user_id: @user.id)
    @userPerformedMission = PerformedMission.where(user_id: @user.id)
    
  end

  def timeline_temp
    @missions = Mission.all
  end
end
