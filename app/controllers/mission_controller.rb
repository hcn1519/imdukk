class MissionController < ApplicationController
  def detail
    @mission = Mission.find(params[:id])
    
    # 미션 제작자
    @mission_creator = User.find(@mission.user_id)
    @users = User.all
    @performed_mission = PerformedMission.where(mission_id: @mission.id)
    
    # 미션 수행자
    @mission_performer = Array.new
    
    @performed_mission.each do |m|
      @mission_performer.push(m.user_id)
    end
    
    # 좋아요 용
    if user_signed_in?
      @userlike = MissionLike.where(:user_id => current_user.id, :mission_like => 1)
      @likeClick = MissionLike.where(:mission_id => @mission.id, :mission_like => 1, :user_id => current_user.id)
    end
    
    @mission_comment = MissionComment.where(:mission_id => @mission.id)
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
    
    @mission.creator_hashtag_list.add(params[:creator_tag], parse: true)
    
    if @mission.save
      redirect_to :back
    else
      render text: @mission.errors.messages[:mission_content].first
    end
    
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
    @mission= Mission.find(params[:id])
    
    # if @post.email == current_user.email
    #   @post.destroy
    # end   
    
    if @mission.user_id == current_user.id
    @mission.destroy
    end
    
    redirect_to :back
  end
  
  def mission_editview
    @mission = Mission.find(params[:id])

    if @mission.user_id != current_user.id
      redirect_to :back
    end
  end
  
  def mission_edit
    @mission = Mission.find(params[:id])
   
    if @mission.user_id == current_user.id
      @mission.title = params[:title] 
      @mission.content = params[:content] 
      @mission.multimedia = params[:multimedia] 
      # @post.category_id = params[:category_id]
      @mission.save
      
      redirect_to controller: 'home', action: "timeline", id: current_user.id
    else 
      redirect_to :back
    end
  end
  

  def performed_mission_destroy
    # 내용 어디에 쓰든 performed_mission_destroy로 오게 한다! --view 
    @performed_mission= PerformedMission.find(params[:id])
    
    if @performed_mission.user_id == current_user.id
      @performed_mission.destroy
    end
    redirect_to :back
  end
  
  def performed_mission_editview
    @performed_mission = PerformedMission.find(params[:id])

    if @performed_mission.user_id != current_user.id
      redirect_to :back
    end
  end
  
  def performed_mission_edit
    @performed_mission = PerformedMission.find(params[:id])
   
    if @performed_mission.user_id == current_user.id
      @performed_mission.content = params[:content] 
      @performed_mission.multimedia = params[:multimedia] 
      # @post.category_id = params[:category_id]
      @performed_mission.save
      
      redirect_to controller: 'home', action: "timeline", id: current_user.id
    else 
      redirect_to :back
    end
  end

  def mission_creator_timeline
    if @mission.creator == current_user
      
    else
      # 수정삭제 안 보여주
    end
  end  

  def missionComment
    @commentedMission = Mission.find(params[:id])
    
    @replyContent = params[:mission_comment]
    
    @missionComment = MissionComment.new
    @missionComment.user_id = current_user.id
    @missionComment.mission_id = @commentedMission.id
    @missionComment.mission_comment = @replyContent
    @missionComment.save
    
    @commentedMission.mission_comment_count = @commentedMission.mission_comment_count + 1
    @commentedMission.save
  end

end
 