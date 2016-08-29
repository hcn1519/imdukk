class MissionController < ApplicationController
  def detail
    @mission = Mission.find(params[:id])
    
    # 미션 제작자
    @mission_creator = User.find(@mission.user_id)
    @users = User.all
    @performed_mission = PerformedMission.where(mission_id: @mission.id)
    
    # 좋아요 용
    if user_signed_in?
      @userlike = MissionLike.where(:user_id => current_user.id, :mission_like => 1)
      @likeClick = MissionLike.where(:mission_id => @mission.id, :mission_like => 1, :user_id => current_user.id)
    end
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
      redirect_to :back
    else
      render text: mission.errors.messages[:mission_content].first
    end
    
    # flash[:notice] = "전송되었습니다!"
    # else
    #   render text: post.errors.messages  
    
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
      # redirect_to '/timeline_temp'/
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
  

  def performed_mission_destroy
    # 내용 어디에 쓰든 performed_mission_destroy로 오게 한다! --view 
    @destroy_performed_mission= PerformedMission.find(params[:id])
    
    # if @mission.email == current_user.email
    @destroy_performed_mission.destroy
    # end
    redirect_to :back
  end
  
  def performed_mission_editview
    @performed_mission = PerformedMission.find(params[:id])

    # if @mission.email != current_user.email
      # redirect_to '/timeline_temp'
    # end
  end
  
  def performed_mission_edit
    @performed_mission = PerformedMission.find(params[:id])
   
    @performed_mission.content = params[:content] 
    @performed_mission.multimedia = params[:multimedia] 
    # @post.category_id = params[:category_id]
    @performed_mission.save
    
    redirect_to '/home/timeline_temp'
  end


  # def missionComment
  #   @commentedMission = Mission.find(params[:id])
    
  #   @commentContent = params[:mission_comment]
    
  #   @missionComment = MissionComment.where(:mission_id => @commentedMission.id, :user_id => current_user.id)
    
  #   # 처음 좋아요 +
  #   if @missionComment.first.nil?
  #     @missionComment = MissionComment.new
  #     @missionComment.user_id = current_user.id
  #     @missionComment.mission_id = @CommentedMission.id
  #     @missionComment.mission_Comment = 1
  #     @missionComment.save
  #     @CommentdMission.mission_Comment_count = @CommentedMission.mission_Comment_count + 1

  #   # 나중
  #   else
  #     # 좋아요 +
  #     if @missionComment.first.mission_Comment == 0 
  #       @missionComment.first.mission_Comment = 1
  #       @CommentdMission.mission_Comment_count = @CommentedMission.mission_Comment_count + 1
  #     # 좋아요 -
  #     else
  #       @missionComment.first.mission_Comment = 0
  #       @CommentdMission.mission_Comment_count = @CommentedMission.mission_Comment_count - 1
  #     end
  #     @missionComment.first.save
  #   end
    
  #   @CommentdMission.save
    
  # end

end
 