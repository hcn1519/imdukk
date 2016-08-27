class HomeController < ApplicationController
  def main
    @missions = Mission.all
    # @one_mission = Mission.find(params[:id])
    
  end
  
  def timeline
  end

end
