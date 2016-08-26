class MissionController < ApplicationController
  def detail
    @missions = Mission.all
    # -> 이게맞냐? 미션은 방금꺼 하나만 떠야돼
    @performed_missions = PerformedMission.all
    # -> 타인의 퍼폼드미션인데..
  end
  
   def mission_create
    @mission = Mission.new
    @mission.title = params[:title]
    @mission.content = params[:content]
    @mission.warning = params[:warning]
    @mission.category_id = params[:category_id]
    @mission.user_id = current_user
    # 지금 로그인 한 사람
    # file = params[:pic]
    # uploader = SnsfbUploader.new
    # ->mission으로바꾸자 uploader부분은 손봐야함
    # uploader.store!(file)
    # performed_mission.pic_address = uploader.url
    # #이건옛날꺼 post.pic_address = params[:pic]
    if @mission.save
      redirect_to "/home/timeline"
    else
      render text: performed_mission.errors.messages[:content].first
    end
    # flash[:notice] = "전송되었습니다!"
    # else
    #   render text: post.errors.messages  
  end
  
  def mission_comment_create
    @current_mission = Mission.find(params[:id])
    @mission_comment = MissionComment.new
    @mission_comment.mission_id = @current_mission.id
    @mission_comment.mission_comment = params[:mission_comment]
    @mission_comment.save
    redirect_to "/mission/detail"
    # -> 미션 작성자의 타임라인으로 가게 하는게 심플할까?
  end
  
  def performed_mission_create
    @current_mission = Mission.find(params[:id])
    @performed_mission = PerformedMission.new
    @performed_mission.title = @current_mission.title
    @performed_mission.mission_id = @current_mission.id
    @performed_mission.category_id = @current_mission.category_id
    @performed_mission.content = params[:content]
    @performed_mission.warning = params[:warning]
    @performed_mission.user_id = current_user
    # 지금 로그인 한 사람
    # file = params[:pic]
    # uploader = SnsfbUploader.new->performed_mission로바꾸자 uploader부분손봐야함
    # uploader.store!(file)
    # performed_mission.pic_address = uploader.url
    # # 이건옛날꺼 post.pic_address = params[:pic]
    if @performed_mission.save
      redirect_to "/home/timeline"
    else
      render text: performed_mission.errors.messages[:content].first
    end
    # flash[:notice] = "전송되었습니다!"
    # else
    #   render text: post.errors.messages  
  end
  
  def performed_mission_comment_create
    @current_performed_mission = PerformedMission.find(params[:id])
    @performed_mission_comment = PerformedMissionComment.new
    @performed_mission_comment.performed_mission_id = @current_performed_mission.id
    @performed_mission_comment.performed_mission_comment = params[:performed_mission_comment]
    @performed_mission_comment.save
    redirect_to "/mission/detail"
    # -> 퍼폼드미션 작성자의 타임라인으로 가게 하는게 심플하다
  end
  
end
