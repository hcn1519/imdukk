class RegisterController < ApplicationController
  before_action :set_user, only: [:info1, :info2, :infoget]
  before_filter :authenticate_user!
  # 카테고리 선택하기 추가
  def info1
  end

  def info2
  end
  
  def infoget
    
    # 이메일 있음
    unless @user.email.nil?
      @user.nickname = params[:nickname]
      @user.save
      
    # 이메일 없음 = twitter
    else
      @user.email = params[:email]
      @user.nickname = params[:nickname]
      @user.save
    end  
    
    redirect_to home_main_path
  end
  
  private
    
  def set_user
    @user = current_user
  end
end
