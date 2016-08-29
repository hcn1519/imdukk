class MissionController < ApplicationController
  def detail
    @mission = Mission.find(params[:id])
    
    # 미션 제작자
    @mission_creator = User.find(@mission.user_id)
    
    @performed_mission = PerformedMission.where(mission_id: @mission.id)
   
    @performed_missions = @performed_mission.all
    
  end
  
  def mission_create
    @mission = Mission.new
    @mission.title = params[:mission_title]
    @mission.content = params[:mission_content]
    @mission.warning = params[:mission_warning]
    @mission.category_id = params[:category_id]
    @mission.user_id = current_user.id
    # 지금 로그인 한 사람
    @mission.multimedia = params[:mission_multimedia]
    
    # file = params[:mission_multimedia]
    # uploader = MissionMultimediaUploader.new
    # uploader.store!(file)
    # @mission.multimedia = uploader.url
    #이건옛날꺼 @mission.multimedia = params[:mission_multimedia]
    
    if @mission.save
      redirect_to "/home/main"
    else
      render text: mission.errors.messages[:mission_content].first
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
    @mission_comment.user_id = current_user.id
    @mission_comment.save
    redirect_to :back
    # -> 미션 작성자의 타임라인으로 가게 하는게 심플할까?
  end
  
  def performed_mission_create
    @current_mission = Mission.find(params[:id])
    @performed_mission = PerformedMission.new
    @performed_mission.title = @current_mission.title
    @performed_mission.mission_id = @current_mission.id
    @performed_mission.category_id = @current_mission.category_id
    @performed_mission.content = params[:performed_mission_content]
    @performed_mission.warning = params[:performed_mission_warning]
    @performed_mission.user_id = current_user.id
    @performed_mission.multimedia = params[:performed_mission_multimedia]

    if @performed_mission.save
      # redirect_to "/mission/detail/" + @current_mission.id.to_s
      redirect_to :back
    else
      render text: performed_mission.errors.messages[:performed_mission_content].first
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
    @performed_mission_comment.user_id = current_user.id
    @performed_mission_comment.save
    # redirect_to "/mission/detail"
    redirect_to :back
  end
    
  def mission_destroy
    # 내용 어디에 쓰든 mission_destroy로 오게 한다! --view 
    @destroy_mission= Mission.find(params[:id])
    
    # if @mission.email == current_user.email
    @destroy_mission.destroy
    # end
    redirect_to :back
  end
  
  def mission_editview
    @mission = Mission.find(params[:id])

    # if @mission.email != current_user.email
      # redirect_to '/timeline_temp'
    # end
  end
  
  def mission_edit
    @mission = Mission.find(params[:id])
   
    @mission.title = params[:title] 
    @mission.content = params[:content] 
    @mission.multimedia = params[:multimedia] 
    # @post.category_id = params[:category_id]
    @mission.save
    
    redirect_to '/home/timeline_temp'
  end
  
  
end
 