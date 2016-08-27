class HomeController < ApplicationController

  def main
  end
  
  def timeline
    @user = current_user
  end

end
